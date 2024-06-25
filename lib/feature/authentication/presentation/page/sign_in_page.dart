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
import 'package:education_app/feature/authentication/presentation/widget/sign_in_form_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  // static const routeName = '/sign-in ';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // initializeLocalization(context);
  }

  @override
  void dispose() {
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    final signInPageTitle =
        context.appLocalizationEXT!.translate('_signInPage_Title_LBL');

    final signInPageDoNotHaveAccountLBL = context.appLocalizationEXT!
        .translate('_signInPage_DoNotHaveAccount_LBL');

    final signInPageRegisterBTN =
        context.appLocalizationEXT!.translate('_signInPage_Register_BTN');

    final signInPageForgotPasswordBTN =
        context.appLocalizationEXT!.translate('_signInPage_ForgotPassword_BTN');

    final signInPageSignInBtnTXT =
        context.appLocalizationEXT!.translate('_signInPage_SignInBTN_TXT');

    final snackBarCheckRequiredSNK =
        context.appLocalizationEXT!.translate('_snackBar_Check_Required_SNK');
    final snackBarCheckInternetSNK =
        context.appLocalizationEXT!.translate('_snackBar_No_Internet_SNK');
    return Scaffold(
      // backgroundColor: Colors.white,
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              // AuthBloc listener logic
              if (state is AuthErrorState) {
                AppSnackBar.showSnackBar(
                  context,
                  state.errorMessage,
                  SnackBarTypeEnum.error,
                );
              } else if (state is SignInSuccessState) {
                context.read<UserProvider>().initUser(state.userEntity);
                authBloc.add(
                  CacheLoginTypeEvent(
                    loginType: LoginStatusEnum
                        .signedInUsingFireBase.info.loginStatusType,
                  ),
                );
              } else if (state is CacheLogInTypeSuccessState) {
                context
                    .pushReplacementNamed(RouterPagesEnum.dashboard.info.name);
              }
            },
          ),
          // BlocListener<LocalizationCubit, LocalizationState>(
          //   listener: (context, state) {
          //     // LocalizationCubit listener logic
          //     // Handle state changes and update UI accordingly
          //   },
          // ),
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
        /*prevent scroll stretching*/
        child: AppScrollConfiguration(
          child: SafeArea(
            child:
                // BlocBuilder<LocalizationCubit, LocalizationState>(
                //   builder: (context, state) {
                // GradientBackgroundWidget
                ListView(
              shrinkWrap: false,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                getLocalizationTextWidget(
                  context,
                  signInPageTitle,
                  const TextStyle(
                    fontFamily: AppFonts.AEONIK,
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                  ),
                ),
                const AppFormFieldSizedBoxWidget(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      signInPageDoNotHaveAccountLBL,
                      style: const TextStyle(fontSize: 14),
                    ),
                    Flexible(
                      child: Align(
                        /*⚠️ use AlignmentDirectional to support RTL*/
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextButton(
                          onPressed: () => context
                              .pushNamed(RouterPagesEnum.signUp.info.name),
                          child: Text(signInPageRegisterBTN),
                        ),
                      ),
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                SignInForm(
                  emailTextEditingController: emailTextEditingController,
                  passwordTextEditingController: passwordTextEditingController,
                  formKey: formKey,
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    onPressed: () => context.pushNamed(
                      RouterPagesEnum.forgotPassword.info.name,
                    ),
                    child: Text(signInPageForgotPasswordBTN),
                  ),
                ),
                // const SizedBox(
                //   height: 30,
                // ),
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
                            buttonLabel: signInPageSignInBtnTXT,
                            buttonOnPressed: () {
                              /*testing Crachlytics by throwing exceptions*/
                              // throw Exception();
                              if (formKey.currentState?.validate() ?? false) {
                                // Form is valid, process the data
                                // Your logic here
                                // context.read<AuthBloc>()
                                // .add(SignInEvent
                                // (email: email, password: password));
                                if (!internetState.isConnected) {
                                  AppSnackBar.showSnackBar(
                                    context,
                                    snackBarCheckInternetSNK,
                                    SnackBarTypeEnum.error,
                                  );
                                  log('Form is inValid');
                                } else {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  FirebaseAuth.instance.currentUser?.reload();
                                  authBloc.add(
                                    SignInEvent(
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
                                  snackBarCheckRequiredSNK,
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
            //   },
            // ),
          ),
        ),
      ),
    );
  }
}

Widget getLocalizationTextWidget(
  BuildContext context,
  String textCode,
  TextStyle textStyle,
) {
  return Text(
    textCode,
    style: textStyle,
  );
}

// Future<void> initializeLocalization(BuildContext context) async {
//   await BlocProvider.of<LocalizationCubit>(context).getLocals(
//     appLanguage: 'en',
//     textCodesMap: {
//       '_hi': 'null', // Indicates that the value needs to be fetched
//       '_hi2': 'null', // Indicates that the value needs to be fetched
//       '_hi3': 'null', // Indicates that the value needs to be fetched
//       '_hi44': 'null', // Indicates that the value needs to be fetched
//       '_hi5': 'null', // Indicates that the value needs to be fetched
//     },
//   );
// }
// Widget getLocalizationTextWidget(
//   String textCode,
//   LocalizationState state,
//   TextStyle textStyle,
// ) {
//   if (state is GetLocalSuccessState) {
//     return Text(
//       state.textCode[textCode]!,
//       style: textStyle,
//     );
//   } else if (state is GetLocalErrorState) {
//     return Text(
//       state.textCode[textCode]!,
//       style: textStyle,
//     );
//   } else {
//     return Text(
//       textCode,
//       style: textStyle,
//     );
//   }
// }
