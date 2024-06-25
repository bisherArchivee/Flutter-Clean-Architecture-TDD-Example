import 'dart:convert';
import 'dart:io';

import 'package:education_app/config/theme/app_media_res.dart';
import 'package:education_app/core/common/constant/constants.dart';
import 'package:education_app/core/common/enum/sharedPreference_enum.dart';
import 'package:education_app/core/common/enum/snackbar_type_enum.dart';
import 'package:education_app/core/common/enum/update_user_enum.dart';
import 'package:education_app/core/common/extension/context_builder_extension.dart';
import 'package:education_app/core/common/feature/internetConnection/presentaion/cubit/internet_cubit.dart';
import 'package:education_app/core/common/feature/internetConnection/presentaion/cubit/internet_state.dart';
import 'package:education_app/core/common/presentation/dialog/app_snackbar_dialog.dart';
import 'package:education_app/core/common/presentation/widget/form_field_sizedbox_widget.dart';
import 'package:education_app/core/common/presentation/widget/scroll_configuration_widget.dart';
import 'package:education_app/core/common/provider/settings_provider.dart';
import 'package:education_app/core/common/provider/user_provider.dart';
import 'package:education_app/feature/authentication/presentation/bloc/auth_bloc.dart';
import 'package:education_app/feature/profile/presentation/widget/edit_profile_form_widget.dart';
import 'package:education_app/feature/profile/presentation/widget/nested_back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final bioController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  File? pickedImage;

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = File(image.path);
      });
    }
  }

  bool get nameChanged =>
      context.read<UserProvider>().userEntity?.displayName.trim() !=
      fullNameController.text.trim();

  bool get emailChanged => emailController.text.trim().isNotEmpty;

  bool get passwordChanged => passwordController.text.trim().isNotEmpty;

  bool get bioChanged =>
      context.read<UserProvider>().userEntity?.bio?.trim() !=
      bioController.text.trim();

  bool get imageChanged => pickedImage != null;

  bool get nothingChanged =>
      !nameChanged &&
      !emailChanged &&
      !passwordChanged &&
      !bioChanged &&
      !imageChanged;

  @override
  void initState() {
    fullNameController.text =
        context.read<UserProvider>().userEntity!.displayName.trim();
    bioController.text =
        context.read<UserProvider>().userEntity!.bio?.trim() ?? '';
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    oldPasswordController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late final editProfilePageTitleSNK =
        context.appLocalizationEXT!.translate('_editProfilePage_Title_SNK');
    late final editProfilePageEditBTNBTN =
        context.appLocalizationEXT!.translate('_editProfilePage_EditBTN_BTN');
    late final editProfilePageOldPasswordValidationSNK = context
        .appLocalizationEXT!
        .translate('_editProfilePage_OldPassword_Validation_SNK');
    late final snackBarCheckRequiredSNK =
        context.appLocalizationEXT!.translate('_snackBar_Check_Required_SNK');
    late final editProfilePageDoneBTNTXT =
        context.appLocalizationEXT!.translate('_editProfilePage_DoneBTN_TXT');

    late final snackBarCheckInternetSNK =
        context.appLocalizationEXT!.translate('_snackBar_No_Internet_SNK');

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is UserUpdatedSuccessState) {
              AppSnackBar.showSnackBar(
                context,
                editProfilePageTitleSNK,
                SnackBarTypeEnum.success,
              );
              context.pop();
            } else if (state is AuthErrorState) {
              AppSnackBar.showSnackBar(
                context,
                state.errorMessage,
                SnackBarTypeEnum.error,
              );
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
      child: Consumer2<UserProvider, SettingsProvider>(
        builder: (context, userProvider, settingsProvider, child) {
          final user = userProvider.userEntity!;

          final userImage = user.photoURL == null || user.photoURL!.isEmpty
              ? null
              : user.photoURL;
          //GradientBackgroundWidget
          return BlocBuilder<InternetCubit, InternetState>(
            builder: (context, internetState) {
              return Scaffold(
                extendBodyBehindAppBar: false,
                // backgroundColor: Colors.white,
                appBar: AppBar(
                  leading: const NestedBackButton(),
                  title: Text(
                    editProfilePageEditBTNBTN,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        if (!internetState.isConnected) {
                          AppSnackBar.showSnackBar(
                            context,
                            snackBarCheckInternetSNK,
                            SnackBarTypeEnum.error,
                          );
                        } else {
                          if (nothingChanged) {
                            context.pop();
                          } else if (formKey.currentState?.validate() ??
                              false) {
                            final bloc = context.read<AuthBloc>();
                            if (passwordChanged) {
                              if (oldPasswordController.text.isEmpty) {
                                AppSnackBar.showSnackBar(
                                  context = context,
                                  editProfilePageOldPasswordValidationSNK,
                                  SnackBarTypeEnum.warning,
                                );
                                return;
                              }
                              bloc.add(
                                UpdateUserDataEvent(
                                  updateUserAction:
                                      UpdateUserActionEnum.password,
                                  userData: jsonEncode({
                                    'oldPassword':
                                        oldPasswordController.text.trim(),
                                    'newPassword':
                                        passwordController.text.trim(),
                                  }),
                                ),
                              );
                            }
                            if (nameChanged) {
                              bloc.add(
                                UpdateUserDataEvent(
                                  updateUserAction:
                                      UpdateUserActionEnum.displayName,
                                  userData: fullNameController.text.trim(),
                                ),
                              );
                            }
                            if (emailChanged) {
                              bloc.add(
                                UpdateUserDataEvent(
                                  updateUserAction: UpdateUserActionEnum.email,
                                  userData: emailController.text.trim(),
                                ),
                              );
                            }
                            if (bioChanged) {
                              bloc.add(
                                UpdateUserDataEvent(
                                  updateUserAction: UpdateUserActionEnum.bio,
                                  userData: bioController.text.trim(),
                                ),
                              );
                            }
                            if (imageChanged) {
                              bloc.add(
                                UpdateUserDataEvent(
                                  updateUserAction:
                                      UpdateUserActionEnum.photoURL,
                                  userData: pickedImage,
                                ),
                              );
                            }
                          } else {
                            AppSnackBar.showSnackBar(
                              context,
                              snackBarCheckRequiredSNK,
                              SnackBarTypeEnum.error,
                            );
                            debugPrint('Form is inValid');
                          }
                        }
                      },
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return state is AuthLoadingState
                              ? const Center(child: CircularProgressIndicator())
                              : StatefulBuilder(
                                  builder: (_, refreshState) {
                                    fullNameController
                                        .addListener(() => refreshState(() {}));
                                    emailController
                                        .addListener(() => refreshState(() {}));
                                    passwordController
                                        .addListener(() => refreshState(() {}));
                                    bioController
                                        .addListener(() => refreshState(() {}));
                                    return Text(
                                      editProfilePageDoneBTNTXT,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: nothingChanged
                                            ? Colors.grey
                                            : Colors.blueAccent,
                                      ),
                                    );
                                  },
                                );
                        },
                      ),
                    ),
                  ],
                ),
                body: AppScrollConfiguration(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: pickedImage != null
                            ? FileImage(pickedImage!)
                            : userImage != null
                                ? NetworkImage(userImage)
                                : const AssetImage(MediaRes.user)
                                    as ImageProvider,
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(.5),
                              ),
                            ),
                            IconButton(
                              onPressed: pickImage,
                              icon: Icon(
                                (pickedImage != null || user.photoURL != null)
                                    ? Icons.edit
                                    : Icons.add_a_photo,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const AppFormFieldSizedBoxWidget(),
                      const AppFormFieldSizedBoxWidget(
                        height: kPageBottomVerticalSpacing,
                      ),
                      EditProfileFormWidget(
                        fullNameController: fullNameController,
                        emailController: emailController,
                        passwordController: passwordController,
                        oldPasswordController: oldPasswordController,
                        bioController: bioController,
                        formKey: formKey,
                      ),
                      const AppFormFieldSizedBoxWidget(),
                      Switch(
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.grey.withOpacity(0.5),
                        // activeTrackColor: AppColors.primaryColour,
                        value: context.read<SettingsProvider>().appTheme ==
                            ThemeMode.dark,
                        onChanged: (value) {
                          final newTheme =
                              value ? ThemeMode.dark : ThemeMode.light;
                          context.read<SettingsProvider>().appTheme = newTheme;
                        },
                      ),
                      Text(
                        "Switch to ${context.read<SettingsProvider>().appTheme == ThemeMode.dark ? 'Light' : 'Dark'} Theme",
                      ),
                      const AppFormFieldSizedBoxWidget(),
                      Switch(
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.grey.withOpacity(0.5),
                        // activeTrackColor: AppColors.primaryColour,
                        value: context.read<SettingsProvider>().appLocal ==
                            Locale(
                                SharedPrefAppLanguageEnum.english.info.value),

                        onChanged: (value) {
                          final newLocal = value
                              ? SharedPrefAppLanguageEnum.english.info.value
                              : SharedPrefAppLanguageEnum.arabic.info.value;

                          context.read<SettingsProvider>().appLocal =
                              Locale(newLocal);
                        },
                      ),
                      Text(
                        "Switch to ${context.read<SettingsProvider>().appLocal == Locale(SharedPrefAppLanguageEnum.english.info.value) ? 'English' : 'Arabic'} Locale",
                      ),
                      const AppFormFieldSizedBoxWidget(),

                      // Switch(activeColor: AppColors.primaryColour,
                      //   inactiveThumbColor: Colors.grey,
                      //   activeTrackColor: Colors.grey,
                      //   value: false,
                      //   onChanged: (value) {
                      //     if (value) {
                      //       context
                      //           .read<SettingsProvider>()
                      //           .appTheme=ThemeMode.light;
                      //     } else {
                      //       context
                      //           .read<SettingsProvider>()
                      //           .appTheme=ThemeMode.dark;
                      //     }
                      //   },
                      // )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
