import 'dart:developer';

import 'package:education_app/config/theme/app_fonts.dart';
import 'package:education_app/core/common/constant/constants.dart';
import 'package:education_app/core/common/enum/login_status_enum.dart';
import 'package:education_app/core/common/enum/router_pages_enum.dart';
import 'package:education_app/core/common/enum/snackbar_type_enum.dart';
import 'package:education_app/core/common/extension/context_builder_extension.dart';
import 'package:education_app/core/common/feature/internetConnection/presentaion/cubit/internet_cubit.dart';
import 'package:education_app/core/common/feature/internetConnection/presentaion/cubit/internet_state.dart';
import 'package:education_app/core/common/presentation/dialog/app_snackbar_dialog.dart';
import 'package:education_app/core/common/presentation/widget/form_field_sizedbox_widget.dart';
import 'package:education_app/core/common/presentation/widget/rounded_button_widget.dart';
import 'package:education_app/core/common/presentation/widget/scroll_configuration_widget.dart';
import 'package:education_app/core/common/provider/user_provider.dart';
import 'package:education_app/feature/authentication/presentation/bloc/auth_bloc.dart';
import 'package:education_app/feature/authentication/presentation/widget/sign_up_form_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  // static const routeName = '/sign-up';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final fullNameTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();

  late final String _signUpPageTitleLBL =
      context.appLocalizationEXT!.translate('_signUpPage_Title_LBL');
  late final String _signUpPageAlReadyHaveAccountLBL = context
      .appLocalizationEXT!
      .translate('_signUpPage_AlReadyHaveAccount_LBL');
  late final String _signUpPageSignInBTN =
      context.appLocalizationEXT!.translate('_signUpPage_SignIn_BTN');
  late final String _signUpPageSignUpBTNTXT =
      context.appLocalizationEXT!.translate('_signUpPage_SignUpBTN_TXT');

  late final String _snackBarCheckRequiredSNK =
      context.appLocalizationEXT!.translate('_snackBar_Check_Required_SNK');

  late final snackBarCheckInternetSNK =
      context.appLocalizationEXT!.translate('_snackBar_No_Internet_SNK');

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    confirmPasswordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      // backgroundColor: Colors.white,
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) async {
              if (state is AuthErrorState) {
                AppSnackBar.showSnackBar(
                  context,
                  state.errorMessage,
                  SnackBarTypeEnum.error,
                );
              } else if (state is SignedUpSuccessState) {
                /*after signed up successfully do login in background
                 * by triggering SignInEvent Automatically*/
                context.read<AuthBloc>().add(
                      SignInEvent(
                        email: emailTextEditingController.text.trim(),
                        password: passwordTextEditingController.text.trim(),
                      ),
                    );
              } else if (state is SignInSuccessState) {
                if (context.mounted) {
                  context.pushReplacementNamed(
                    RouterPagesEnum.dashboard.info.name,
                  );
                }
                context.read<UserProvider>().initUser(state.userEntity);
                authBloc.add(
                  CacheLoginTypeEvent(
                    loginType: LoginStatusEnum
                        .signedInUsingFireBase.info.loginStatusType,
                  ),
                );

                // Navigator.pushReplacementNamed
                // (context, DashBoardPage.routeName);
              }
            },
          ),
          BlocListener<InternetCubit, InternetState>(
            listener: (context, state) {
              debugPrint('🟡InternetCubitState');
              if (state is InternetDisconnected) {
                // Handle no internet connection
                AppSnackBar.showSnackBar(
                  context,
                  snackBarCheckInternetSNK,
                  SnackBarTypeEnum.error,
                );
              }
            },
          ),
        ],
        child: SafeArea(
          child: AppScrollConfiguration(
            // GradientBackgroundWidget
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                Text(
                  _signUpPageTitleLBL,
                  style: const TextStyle(
                    fontFamily: AppFonts.AEONIK,
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
                ),
                const AppFormFieldSizedBoxWidget(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        _signUpPageAlReadyHaveAccountLBL,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: TextButton(
                        onPressed: () => context.pushReplacementNamed(
                            RouterPagesEnum.signIn.info.name),
                        child: Text(_signUpPageSignInBTN),
                      ),
                    ),
                  ],
                ),
                const AppFormFieldSizedBoxWidget(),
                SignUpForm(
                  fullNameTextEditingController: fullNameTextEditingController,
                  emailTextEditingController: emailTextEditingController,
                  passwordTextEditingController: passwordTextEditingController,
                  confirmPasswordTextEditingController:
                      confirmPasswordTextEditingController,
                  formKey: formKey,
                ),
                const AppFormFieldSizedBoxWidget(
                  height: kPageBottomVerticalSpacing,
                ),
                BlocBuilder<InternetCubit, InternetState>(
                  builder: (context, internetState) {
                    return BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return RoundedButtonWidget(
                            buttonLabel: _signUpPageSignUpBTNTXT,
                            buttonOnPressed: () {
                              if (formKey.currentState?.validate() ?? false) {
                                if (!internetState.isConnected) {
                                  AppSnackBar.showSnackBar(
                                    context,
                                    snackBarCheckInternetSNK,
                                    SnackBarTypeEnum.error,
                                  );
                                } else {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  FirebaseAuth.instance.currentUser?.reload();
                                  BlocProvider.of<AuthBloc>(context).add(
                                    SignUpEvent(
                                      name: fullNameTextEditingController.text
                                          .trim(),
                                      email: emailTextEditingController.text
                                          .trim(),
                                      password: passwordTextEditingController
                                          .text
                                          .trim(),
                                    ),
                                  );
                                }
                                log('Form is valid');
                              } else {
                                AppSnackBar.showSnackBar(
                                  context,
                                  _snackBarCheckRequiredSNK,
                                  SnackBarTypeEnum.error,
                                );
                                log('Form is inValid');
                              }
                            },
                          );
                        }
                      },
                    );
                  },
                ),
                const AppFormFieldSizedBoxWidget(
                  height: kPageBottomVerticalSpacing,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    //  return  const Placeholder(
    //   child: Center(
    //     child: Text(
    //       'signIn',
    //       textAlign: TextAlign.center,
    //       style: TextStyle(
    //         color: AppColors.primaryColour,
    //         fontFamily: AppFonts.AEONIK,
    //         fontSize: 40,
    //         fontWeight: FontWeight.w700,
    //       ),
    //     ),
    //   ),
    // );
  }
}
