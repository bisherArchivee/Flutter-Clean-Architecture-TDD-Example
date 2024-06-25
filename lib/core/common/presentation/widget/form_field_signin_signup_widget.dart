import 'package:education_app/core/common/enum/form_field_type_enum.dart';
import 'package:education_app/core/common/extension/context_builder_extension.dart';
import 'package:flutter/material.dart';

class AppFormSignInFieldWidget extends StatelessWidget {
  const AppFormSignInFieldWidget({
    required this.controller,
    this.passController,
    this.filled = false,
    this.formFieldTypeEnum = FormFieldTypeEnum.normal,
    this.obscureText = false,
    this.readOnly = false,
    this.validator,
    this.fillColour,
    this.suffixIcon,
    this.fieldTitle,
    this.hintText,
    this.keyboardType,
    this.hintStyle,
    this.overrideValidator = false,
    super.key,
  });

  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextEditingController? passController;
  final bool filled;
  final Color? fillColour;
  final FormFieldTypeEnum formFieldTypeEnum;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final String? fieldTitle;

  final String? hintText;
  final TextInputType? keyboardType;
  final bool overrideValidator;
  final TextStyle? hintStyle;

  // String _formFieldFieldRequiredLBL = '';
  // String _formFieldPasswordMINLBL = '';
  // String _formFieldPasswordMAXLBL = '';
  // String _formFieldPasswordsNotMatchLBL = '';
  // String _formFieldEmailRequiredLBL = '';
  // String _formFieldInvalidEmailLBL = '';

  @override
  Widget build(BuildContext context) {
    final formFieldFieldRequiredLBL =
        context.appLocalizationEXT!.translate('_formField_Field_Required_LBL');
    final formFieldPasswordMINLBL =
        context.appLocalizationEXT!.translate('_formField_Password_MIN_LBL');
    final formFieldPasswordMAXLBL =
        context.appLocalizationEXT!.translate('_formField_Password_MAX_LBL');
    final formFieldPasswordsNotMatchLBL = context.appLocalizationEXT!
        .translate('_formField_Passwords_Not_Match_LBL');
    final formFieldEmailRequiredLBL =
        context.appLocalizationEXT!.translate('_formField_Email_Required_LBL');
    final formFieldInvalidEmailLBL =
        context.appLocalizationEXT!.translate('_formField_Invalid_Email_LBL');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (fieldTitle != null)
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              fieldTitle!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
        if (fieldTitle != null) const SizedBox(height: 3),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          onTapOutside: (_) {
            FocusScope.of(context).unfocus();
          },
          keyboardType: keyboardType,
          obscureText: obscureText,
          readOnly: readOnly,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(90),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(90),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(90),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
            // overwriting the default padding helps with that puffy look
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            filled: filled,
            fillColor: fillColour,
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: hintStyle ??
                const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
          ),
          // maxLength: formFieldTypeEnum == FormFieldTypeEnum.password
          //     ? 15
          //     : null,
          validator: (value) {
            if (overrideValidator) {
              return validator?.call(value);
            } else {
              switch (formFieldTypeEnum) {
                case FormFieldTypeEnum.normal:
                  return validateNormalField(
                    value!,
                    formFieldFieldRequiredLBL: formFieldFieldRequiredLBL,
                  );
                case FormFieldTypeEnum.password:
                  return validatePassword(
                    value!,
                    formFieldFieldRequiredLBL: formFieldFieldRequiredLBL,
                    formFieldPasswordMAXLBL: formFieldPasswordMAXLBL,
                    formFieldPasswordMINLBL: formFieldPasswordMINLBL,
                  );
                case FormFieldTypeEnum.confirmPassword:
                  return validateConfirmPassword(
                    value!,
                    passController,
                    formFieldPasswordsNotMatchLBL:
                        formFieldPasswordsNotMatchLBL,
                  );
                case FormFieldTypeEnum.phone:
                  return null;
                case FormFieldTypeEnum.email:
                  return validateEmail(
                    value!,
                    formFieldEmailRequiredLBL: formFieldEmailRequiredLBL,
                    formFieldInvalidEmailLBL: formFieldInvalidEmailLBL,
                  );
                case FormFieldTypeEnum.number:
                  return null;
                case FormFieldTypeEnum.date:
                  return null;
              }
            }
          },
        ),
        // const SizedBox(height: 25),
      ],
    );
  }

  String? validatePassword(
    String value, {
    required String formFieldFieldRequiredLBL,
    required String formFieldPasswordMINLBL,
    required String formFieldPasswordMAXLBL,
  }) {
    if (value.isEmpty) {
      return formFieldFieldRequiredLBL;
    } else if (value.length < 6) {
      return formFieldPasswordMINLBL;
    } else if (value.length > 15) {
      return formFieldPasswordMAXLBL;
    } else {
      return null;
    }
  }

  String? validateConfirmPassword(
    String value,
    TextEditingController? passController, {
    required String formFieldPasswordsNotMatchLBL,
  }) {
    if (value != passController?.value.text) {
      return formFieldPasswordsNotMatchLBL;
    } else {
      return null;
    }
  }

  String? validateNormalField(
    String value, {
    required String formFieldFieldRequiredLBL,
  }) {
    if (value.isEmpty) {
      return formFieldFieldRequiredLBL;
    } else {
      return null;
    }
  }

  String? validateEmail(
    String value, {
    required String formFieldEmailRequiredLBL,
    required String formFieldInvalidEmailLBL,
  }) {
    // Simple email validation using a regular expression
    // This is a basic example, and you may want to use a more robust
    // email validation
    // Regular expression source: https://regexlib.com/REDetails.aspx?regexp_id=26
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$',
    );

    if (value.isEmpty) {
      return formFieldEmailRequiredLBL;
    } else if (!emailRegex.hasMatch(value)) {
      return formFieldInvalidEmailLBL;
    } else {
      return null;
    }
  }
}
