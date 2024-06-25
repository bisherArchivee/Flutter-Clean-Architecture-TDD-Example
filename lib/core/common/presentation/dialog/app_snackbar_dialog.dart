import 'package:education_app/core/common/enum/snackbar_type_enum.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  factory AppSnackBar() {
    return _instance;
  }

  // Private constructor to prevent instantiation from outside
  AppSnackBar._();

  static final AppSnackBar _instance = AppSnackBar._();

  static void showSnackBar(
    BuildContext context,
    String message,
    SnackBarTypeEnum snackBarTypeEnum,
  ) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: snackBarTypeEnum.info(context).color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(10),
          // duration: Duration(seconds: 2),
        ),
      );
  }
}
