import 'package:education_app/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  const RoundedButtonWidget({
    required this.buttonLabel,
    required this.buttonOnPressed,
    this.buttonBGColour,
    this.buttonFGColour,
    super.key,
  });

  final String buttonLabel;
  final VoidCallback buttonOnPressed;
  final Color? buttonBGColour;
  final Color? buttonFGColour;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 17,
        ),
        backgroundColor:
            buttonBGColour ?? AppTheme.getThemePrimaryColor(context),
        foregroundColor: buttonFGColour ?? Colors.white,
        minimumSize: const Size(double.maxFinite, 48),
      ),
      onPressed: buttonOnPressed.call,
      child: Text(buttonLabel),
      // AppFormFieldSizedBoxWidget(
      //   height: context.heightEXT * 0.035,
      //   child: Text(buttonLabel),
      // ),
    );
  }
}
