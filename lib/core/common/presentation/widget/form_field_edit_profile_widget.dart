import 'package:education_app/core/common/enum/form_field_type_enum.dart';
import 'package:education_app/core/common/presentation/widget/form_field_signin_signup_widget.dart';
import 'package:flutter/material.dart';

class AppFormEditFieldWidget extends AppFormSignInFieldWidget {
  const AppFormEditFieldWidget({
    required TextEditingController controller,
    TextEditingController? passController,
    bool filled = false,
    FormFieldTypeEnum formFieldTypeEnum = FormFieldTypeEnum.normal,
    bool obscureText = false,
    bool readOnly = false,
    String? Function(String?)? validator,
    Color? fillColour,
    Widget? suffixIcon,
    String? fieldTitle,
    String? hintText,
    TextInputType? keyboardType,
    bool overrideValidator = false,
    TextStyle? hintStyle,
    Key? key,
  }) : super(
          controller: controller,
          passController: passController,
          filled: filled,
          formFieldTypeEnum: formFieldTypeEnum,
          obscureText: obscureText,
          readOnly: readOnly,
          validator: validator,
          fillColour: fillColour,
          suffixIcon: suffixIcon,
          fieldTitle: fieldTitle,
          hintText: hintText,
          keyboardType: keyboardType,
          hintStyle: hintStyle,
          overrideValidator: overrideValidator,
          key: key,
        );

  //
  // final String? Function(String?)? validator;
  // final TextEditingController controller;
  // final TextEditingController? passController;
  // final bool filled;
  // final Color? fillColour;
  // final FormFieldTypeEnum formFieldTypeEnum;
  // final bool obscureText;
  // final bool readOnly;
  // final Widget? suffixIcon;
  // final String? fieldTitle;
  //
  // final String? hintText;
  // final TextInputType? keyboardType;
  // final bool overrideValidator;
  // final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    // Reuse the build method from the parent class
    Widget parentBuild = super.build(context);

    // You can add additional customization or modify the widget returned by the parent class
    // ...

    // Return the modified or original widget
    return parentBuild;
  }
}
