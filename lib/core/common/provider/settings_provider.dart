import 'package:education_app/core/common/enum/sharedPreference_enum.dart';
import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = Locale(SharedPrefAppLanguageEnum.english.info.value);

  ThemeMode get appTheme => _themeMode;

  set appTheme(ThemeMode themeMode) {
    if (themeMode != _themeMode) {
      _themeMode = themeMode;
    }

    /*we need to update the ui if there is a user  data update
      but if the page in building state
      it will throw an error that's why we need to delay */
    Future.delayed(Duration.zero, notifyListeners);
  }

  Locale get appLocal => _locale;

  set appLocal(Locale locale) {
    if (locale != _locale) {
      _locale = locale;

      /*we need to update the ui if there is a user  data update
      but if the page in building state
      it will throw an error that's why we need to delay */
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
