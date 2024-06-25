import 'dart:convert' show json;

import 'package:education_app/core/common/feature/localizationFromJSON/app_localizations_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  Map<String, String> _localizedStrings = {};

  /* Load the JSON file and convert it to MAP*/
  Future<void> load() async {
    final jsonString = await rootBundle
        .loadString('assets/translations/${locale.languageCode}.json');
    // final Map<String, String> jsonMap = json.decode(jsonString);
    final Object? data = json.decode(jsonString);
    if (data is Map) {
      final Map<String, dynamic> jsonMap = data.cast<String, Object>();
      _localizedStrings = jsonMap.map<String, String>((key, value) {
        return MapEntry(key, value.toString());
      });
    }
  }

  /* to load string by key*/
  String translate(String key) => _localizedStrings[key] ?? key;

// bool get isEnLocale => locale.languageCode == 'en';
}
