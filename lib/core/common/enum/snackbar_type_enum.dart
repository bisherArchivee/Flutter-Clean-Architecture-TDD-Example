import 'package:education_app/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

enum SnackBarTypeEnum {
  appTheme,
  warning,
  error,
  success,
}

class SnackBarTypeInfo {
  SnackBarTypeInfo(this.color);

  // SnackBarTypeInfo(this.key, this.value);

  // final String key;
  final Color color;
}

extension Extension on SnackBarTypeEnum {
  SnackBarTypeInfo info(BuildContext context) {
    switch (this) {
      case SnackBarTypeEnum.appTheme:
        return SnackBarTypeInfo(AppTheme.getThemePrimaryColor(context));
      case SnackBarTypeEnum.warning:
        return SnackBarTypeInfo(Colors.yellow);
      case SnackBarTypeEnum.error:
        return SnackBarTypeInfo(Colors.red);
      case SnackBarTypeEnum.success:
        return SnackBarTypeInfo(Colors.green);
    }
  }
}
