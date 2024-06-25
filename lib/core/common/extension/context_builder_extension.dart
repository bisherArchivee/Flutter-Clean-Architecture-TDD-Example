import 'package:education_app/core/common/feature/localizationFromJSON/app_localizations.dart';
import 'package:flutter/material.dart';

extension ContextBuilderExtension on BuildContext {
  /*Theme */
  ThemeData get themeEXT => Theme.of(this);

  /*Media Query*/
  MediaQueryData get mediaQueryEXT => MediaQuery.of(this);

  Size get sizeEXT => mediaQueryEXT.size;

  /*Height-Width*/
  double get widthEXT => sizeEXT.width;

  double get heightEXT => sizeEXT.height;

  /*App Localization*/
  AppLocalizations? get appLocalizationEXT => AppLocalizations.of(this);
}
