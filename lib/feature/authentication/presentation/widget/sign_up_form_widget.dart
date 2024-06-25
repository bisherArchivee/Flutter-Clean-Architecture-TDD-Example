import 'package:education_app/core/common/enum/form_field_type_enum.dart';
import 'package:education_app/core/common/extension/context_builder_extension.dart';
import 'package:education_app/core/common/presentation/widget/form_field_signin_signup_widget.dart';
import 'package:education_app/core/common/presentation/widget/form_field_sizedbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    required this.fullNameTextEditingController,
    required this.emailTextEditingController,
    required this.passwordTextEditingController,
    required this.confirmPasswordTextEditingController,
    required this.formKey,
    super.key,
  });

  final TextEditingController fullNameTextEditingController;
  final TextEditingController emailTextEditingController;
  final TextEditingController passwordTextEditingController;
  final TextEditingController confirmPasswordTextEditingController;

  final GlobalKey<FormState> formKey;

  @override
  State<SignUpForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignUpForm> {
  bool obscuredPassword = true;

  late final _fullNameFormLBL =
      context.appLocalizationEXT!.translate('_fullNameForm_LBL');
  late final _emailFormLBL =
      context.appLocalizationEXT!.translate('_emailForm_LBL');
  late final _passwordFormLBL =
      context.appLocalizationEXT!.translate('_passwordForm_LBL');
  late final _confirmFormPasswordLBL =
      context.appLocalizationEXT!.translate('_confirmForm_Password_LBL');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min, //use this
        children: [
          AppFormSignInFieldWidget(
            controller: widget.fullNameTextEditingController,
            hintText: _fullNameFormLBL,
            keyboardType: TextInputType.text,
          ),
          const AppFormFieldSizedBoxWidget(),
          AppFormSignInFieldWidget(
            controller: widget.emailTextEditingController,
            hintText: _emailFormLBL,
            keyboardType: TextInputType.emailAddress,
            formFieldTypeEnum: FormFieldTypeEnum.email,
          ),
          const AppFormFieldSizedBoxWidget(),
          AppFormSignInFieldWidget(
            controller: widget.passwordTextEditingController,
            hintText: _passwordFormLBL,
            keyboardType: TextInputType.visiblePassword,
            formFieldTypeEnum: FormFieldTypeEnum.password,
            obscureText: obscuredPassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscuredPassword = !obscuredPassword;
                });
              },
              icon:
                  Icon(obscuredPassword ? IconlyLight.hide : IconlyLight.show),
              color: Colors.grey,
            ),
          ),
          const AppFormFieldSizedBoxWidget(),
          AppFormSignInFieldWidget(
            controller: widget.confirmPasswordTextEditingController,
            passController: widget.passwordTextEditingController,
            hintText: _confirmFormPasswordLBL,
            keyboardType: TextInputType.visiblePassword,
            formFieldTypeEnum: FormFieldTypeEnum.confirmPassword,
            obscureText: obscuredPassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscuredPassword = !obscuredPassword;
                });
              },
              icon:
                  Icon(obscuredPassword ? IconlyLight.hide : IconlyLight.show),
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
