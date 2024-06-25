import 'package:education_app/core/common/enum/form_field_type_enum.dart';
import 'package:education_app/core/common/extension/context_builder_extension.dart';
import 'package:education_app/core/common/extension/string_extension.dart';
import 'package:education_app/core/common/presentation/widget/form_field_edit_profile_widget.dart';
import 'package:education_app/core/common/presentation/widget/form_field_sizedbox_widget.dart';
import 'package:education_app/core/common/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class EditProfileFormWidget extends StatelessWidget {
  const EditProfileFormWidget({
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.oldPasswordController,
    required this.bioController,
    required this.formKey,
    super.key,
  });

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController oldPasswordController;
  final TextEditingController bioController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    var obscuredPassword = true;

    final fullNameFormLBL =
        context.appLocalizationEXT!.translate('_fullNameForm_LBL');
    final emailFormLBL =
        context.appLocalizationEXT!.translate('_emailForm_LBL');
    final currentPasswordFormLBL =
        context.appLocalizationEXT!.translate('_currentPasswordForm_LBL');
    final newPasswordFormLBL =
        context.appLocalizationEXT!.translate('_newPasswordForm_LBL');
    final passwordFormHNT =
        context.appLocalizationEXT!.translate('_passwordForm_HNT');
    final fillCurrentPasswordFormLBL =
        context.appLocalizationEXT!.translate('_fill_CurrentPasswordForm_LBL');
    final bioLBL = context.appLocalizationEXT!.translate('_bio_LBL');

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppFormEditFieldWidget(
            fieldTitle: fullNameFormLBL,
            controller: fullNameController,
            hintText: context.read<UserProvider>().userEntity!.displayName,
            // formFieldTypeEnum: FormFieldTypeEnum.normal,
            // overrideValidator: fullNameController.text.isNotEmpty,
          ),
          const AppFormFieldSizedBoxWidget(),
          AppFormEditFieldWidget(
            fieldTitle: emailFormLBL,
            controller: emailController,
            hintText:
                context.read<UserProvider>().userEntity!.email.obscureEmail,
            formFieldTypeEnum: FormFieldTypeEnum.email,
            // overrideValidator: emailController.text.isNotEmpty,
          ),
          const AppFormFieldSizedBoxWidget(),
          StatefulBuilder(
            builder: (context, setState) {
              return AppFormEditFieldWidget(
                fieldTitle: currentPasswordFormLBL,
                controller: oldPasswordController,
                hintText: passwordFormHNT,
                formFieldTypeEnum: FormFieldTypeEnum.password,
                obscureText: obscuredPassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscuredPassword = !obscuredPassword;
                    });
                  },
                  icon: Icon(
                    obscuredPassword ? IconlyLight.hide : IconlyLight.show,
                  ),
                  color: Colors.grey,
                ),
                // overrideValidator: oldPasswordController.text.isEmpty,
              );
            },
          ),
          const AppFormFieldSizedBoxWidget(),
          StatefulBuilder(
            builder: (_, setState) {
              oldPasswordController.addListener(
                () => setState(() {
                  if (oldPasswordController.text.isEmpty) {
                    passwordController.clear();
                  }
                }),
              );
              return AppFormEditFieldWidget(
                fieldTitle: newPasswordFormLBL,
                controller: passwordController,
                hintText: fillCurrentPasswordFormLBL,
                readOnly: oldPasswordController.text.isEmpty,
                // overrideValidator: passwordController.text.isNotEmpty,
                formFieldTypeEnum: FormFieldTypeEnum.password,
                obscureText: obscuredPassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscuredPassword = !obscuredPassword;
                    });
                  },
                  icon: Icon(
                    obscuredPassword ? IconlyLight.hide : IconlyLight.show,
                  ),
                  color: Colors.grey,
                ),
              );
            },
          ),
          const AppFormFieldSizedBoxWidget(),
          AppFormEditFieldWidget(
            fieldTitle: bioLBL,
            controller: bioController,
            hintText:
                context.read<UserProvider>().userEntity!.bio?.trim() ?? '',
            // overrideValidator: bioController.text.isNotEmpty,
          ),
        ],
      ),
    );
  }
}
