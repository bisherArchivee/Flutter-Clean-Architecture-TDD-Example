import 'package:education_app/core/common/enum/sharedPreference_enum.dart';
import 'package:flutter/material.dart' show Locale, LocalizationsDelegate;

import 'app_localizations.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return [
      SharedPrefAppLanguageEnum.english.info.value,
      SharedPrefAppLanguageEnum.arabic.info.value
    ].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final appLocalizations = AppLocalizations(locale);
    await appLocalizations.load();
    return appLocalizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
