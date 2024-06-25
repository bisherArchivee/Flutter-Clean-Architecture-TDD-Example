class SharedPreferencesValue {
  SharedPreferencesValue(this.value);

  final String value;
}

/*---------------------------------------------------------------------*/
enum SharedPrefLoginStatusEnum {
  loginStatusKey,
  signedOut,
  signedInUsingFireBase,
  signedInUsingFaceBook,
  signedInUsingGoogle,
  signedInUsingICloud,
  signedInUsingEmailPassword,
}

extension SharedPrefLoginStatusExtension on SharedPrefLoginStatusEnum {
  SharedPreferencesValue get info {
    switch (this) {
      case SharedPrefLoginStatusEnum.loginStatusKey:
        return SharedPreferencesValue('login_type');
      case SharedPrefLoginStatusEnum.signedOut:
        return SharedPreferencesValue('signed_out');
      case SharedPrefLoginStatusEnum.signedInUsingFaceBook:
        return SharedPreferencesValue('facebook');
      case SharedPrefLoginStatusEnum.signedInUsingFireBase:
        return SharedPreferencesValue('firebase');
      case SharedPrefLoginStatusEnum.signedInUsingGoogle:
        return SharedPreferencesValue('google');
      case SharedPrefLoginStatusEnum.signedInUsingICloud:
        return SharedPreferencesValue('icloud');
      case SharedPrefLoginStatusEnum.signedInUsingEmailPassword:
        return SharedPreferencesValue('email_pass');
    }
  }
}

/*---------------------------------------------------------------------*/
enum SharedPrefAppThemeEnum {
  darkThemeKey,
  dark,
  light,
}

extension SharedPrefAppThemeExtension on SharedPrefAppThemeEnum {
  SharedPreferencesValue get info {
    switch (this) {
      case SharedPrefAppThemeEnum.darkThemeKey:
        return SharedPreferencesValue('app_theme');
      case SharedPrefAppThemeEnum.dark:
        return SharedPreferencesValue('dark');
      case SharedPrefAppThemeEnum.light:
        return SharedPreferencesValue('light');
    }
  }
}

/*---------------------------------------------------------------------*/
enum SharedPrefAppLanguageEnum {
  appLanguageKey,
  arabic,
  english,
}

extension SharedPrefAppLanguageExtension on SharedPrefAppLanguageEnum {
  SharedPreferencesValue get info {
    switch (this) {
      case SharedPrefAppLanguageEnum.appLanguageKey:
        return SharedPreferencesValue('app_language');
      case SharedPrefAppLanguageEnum.arabic:
        return SharedPreferencesValue('ar');
      case SharedPrefAppLanguageEnum.english:
        return SharedPreferencesValue('en');
    }
  }
}
