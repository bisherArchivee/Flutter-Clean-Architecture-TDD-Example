import 'package:education_app/core/common/constant/constants.dart';
import 'package:flutter/material.dart';

class AppFormFieldSizedBoxWidget extends StatelessWidget {
  const AppFormFieldSizedBoxWidget({
    this.height,
    this.child,
    super.key,
  });

  final double? height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? kFormFieldVerticalSpacing,
      child: child,
    );
  }
}
