import 'package:education_app/core/common/constant/constants.dart';
import 'package:education_app/core/common/presentation/widget/form_field_signin_signup_widget.dart';
import 'package:education_app/core/common/presentation/widget/form_field_sizedbox_widget.dart';
import 'package:flutter/material.dart';

class EditProfileFormField extends StatelessWidget {
  const EditProfileFormField({
    required this.fieldTitle,
    required this.controller,
    super.key,
    this.hintText,
    this.readOnly = false,
  });

  final String fieldTitle;
  final TextEditingController controller;
  final String? hintText;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            fieldTitle,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        const AppFormFieldSizedBoxWidget(),
        AppFormSignInFieldWidget(
          controller: controller,
          hintText: hintText,
          readOnly: readOnly,
        ),
        const AppFormFieldSizedBoxWidget(height: kPageBottomVerticalSpacing),
      ],
    );
  }
}
