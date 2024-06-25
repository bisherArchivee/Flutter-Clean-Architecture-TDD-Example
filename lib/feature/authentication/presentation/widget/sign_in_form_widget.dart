import 'package:education_app/core/common/enum/form_field_type_enum.dart';
import 'package:education_app/core/common/extension/context_builder_extension.dart';
import 'package:education_app/core/common/presentation/widget/form_field_signin_signup_widget.dart';
import 'package:education_app/core/common/presentation/widget/form_field_sizedbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    required this.emailTextEditingController,
    required this.passwordTextEditingController,
    required this.formKey,
    super.key,
  });

  final TextEditingController emailTextEditingController;

  final TextEditingController passwordTextEditingController;

  final GlobalKey<FormState> formKey;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool obscuredPassword = true;

  @override
  Widget build(BuildContext context) {
    final emailLBL = context.appLocalizationEXT!.translate('_emailForm_LBL');

    final passwordLBL =
        context.appLocalizationEXT!.translate('_passwordForm_LBL');

    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          AppFormSignInFieldWidget(
            controller: widget.emailTextEditingController,
            hintText: emailLBL,
            keyboardType: TextInputType.emailAddress,
            formFieldTypeEnum: FormFieldTypeEnum.email,
          ),
          const AppFormFieldSizedBoxWidget(),
          AppFormSignInFieldWidget(
            controller: widget.passwordTextEditingController,
            hintText: passwordLBL,
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
        ],
      ),
    );
  }
}
