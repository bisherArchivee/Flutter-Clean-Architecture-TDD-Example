import 'package:education_app/core/app/errors/exception.dart';
import 'package:education_app/core/common/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesLocalDataSource {
  Future<void> setString({
    required String key,
    required String value,
  });

  Future<void> setBool({
    required String key,
    required bool value,
  });

  Future<void> setDouble({
    required String key,
    required double value,
  });

  Future<void> setInt({
    required String key,
    required int value,
  });

  Future<void> setStringList({
    required String key,
    required List<String> value,
  });

  Future<Map<String, String>> getString(String key);

  Future<Map<String, bool>> getBool(String key);

  Future<Map<String, double>?> getDouble(String key);

  Future<Map<String, int>> getInt(String key);

  Future<Map<String, List<String>>> getStringList(String key);
}

class SharedPreferencesLocalDataSourceImpl
    implements SharedPreferencesLocalDataSource {
  SharedPreferencesLocalDataSourceImpl({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Future<Map<String, bool>> getBool(String key) async {
    try {
      final resultMap = <String, bool>{};
      final result = sharedPreferences.getBool(key);

      if (result == null) {
        resultMap[key] = false;
      } else {
        resultMap[key] = result;
      }

      return resultMap;
    } catch (e) {
      debugPrint('‼️ SharedPreferencesLocalDataSource CacheException: $e');
      throw CacheException(message: e.toString(), statusCode: kCacheStatusCode);
    }
  }

  @override
  Future<Map<String, double>?> getDouble(String key) async {
    try {
      final resultMap = <String, double>{};
      final result = sharedPreferences.getDouble(key);
      if (result == null) {
        resultMap[key] = -1.0;
      } else {
        resultMap[key] = result;
      }

      return resultMap;
    } catch (e) {
      debugPrint('‼️ SharedPreferencesLocalDataSource CacheException: $e');
      throw CacheException(message: e.toString(), statusCode: kCacheStatusCode);
    }
  }

  @override
  Future<Map<String, int>> getInt(String key) async {
    try {
      final resultMap = <String, int>{};
      final result = sharedPreferences.getInt(key);
      if (result == null) {
        resultMap[key] = -1;
      } else {
        resultMap[key] = result;
      }
      return resultMap;
    } catch (e) {
      debugPrint('‼️ SharedPreferencesLocalDataSource CacheException: $e');
      throw CacheException(message: e.toString(), statusCode: kCacheStatusCode);
    }
  }

  @override
  Future<Map<String, String>> getString(String key) async {
    try {
      final resultMap = <String, String>{};
      final result = sharedPreferences.getString(key);
      if (result == null) {
        resultMap[key] = key;
      } else {
        resultMap[key] = result;
      }
      return resultMap;
    } catch (e) {
      debugPrint('‼️ SharedPreferencesLocalDataSource CacheException: $e');
      throw CacheException(message: e.toString(), statusCode: kCacheStatusCode);
    }
  }

  @override
  Future<Map<String, List<String>>> getStringList(String key) async {
    try {
      final result = sharedPreferences.getStringList(key);
      final resultMap = <String, List<String>>{};
      if (result == null) {
        resultMap[key] = [];
      } else {
        resultMap[key] = result;
      }
      return resultMap;
    } catch (e) {
      debugPrint('‼️ SharedPreferencesLocalDataSource CacheException: $e');
      throw CacheException(message: e.toString(), statusCode: kCacheStatusCode);
    }
  }

  @override
  Future<void> setBool({
    required String key,
    required bool value,
  }) async {
    try {
      await sharedPreferences.setBool(key, value);
    } catch (e) {
      debugPrint('‼️ SharedPreferencesLocalDataSource CacheException: $e');
      throw CacheException(message: e.toString(), statusCode: kCacheStatusCode);
    }
  }

  @override
  Future<void> setDouble({
    required String key,
    required double value,
  }) async {
    try {
      await sharedPreferences.setDouble(key, value);
    } catch (e) {
      debugPrint('‼️ SharedPreferencesLocalDataSource CacheException: $e');
      throw CacheException(message: e.toString(), statusCode: kCacheStatusCode);
    }
  }

  @override
  Future<void> setInt({
    required String key,
    required int value,
  }) async {
    try {
      await sharedPreferences.setInt(key, value);
    } catch (e) {
      debugPrint('‼️ SharedPreferencesLocalDataSource CacheException: $e');
      throw CacheException(message: e.toString(), statusCode: kCacheStatusCode);
    }
  }

  @override
  Future<void> setString({
    required String key,
    required String value,
  }) async {
    try {
      await sharedPreferences.setString(key, value);
    } catch (e) {
      debugPrint('‼️ SharedPreferencesLocalDataSource CacheException: $e');
      throw CacheException(message: e.toString(), statusCode: kCacheStatusCode);
    }
  }

  @override
  Future<void> setStringList({
    required String key,
    required List<String> value,
  }) async {
    try {
      await sharedPreferences.setStringList(key, value);
    } catch (e) {
      debugPrint('‼️ SharedPreferencesLocalDataSource CacheException: $e');
      throw CacheException(message: e.toString(), statusCode: kCacheStatusCode);
    }
  }
}

// @override
// Future<String> getLoginStatus() async {
//   try {
//     final result = sharedPreferences.getString(kLoginStatusTypeKey);
//     return result ?? LoginStatusEnum.signedOut.info.loginStatusType;
//   } catch (e) {
//    throw CacheException(message: e.toString(), statusCode: kCacheStatusCode);
//   }
// }
//
// @override
// Future<bool> isDarkTheme() async {
//   try {
//     final result = sharedPreferences.getBool(kIsDarkThemeEnabledKey);
//     return result ?? false;
//   } catch (e) {
//    throw CacheException(message: e.toString(), statusCode: kCacheStatusCode);
//   }
// }
//
// @override
// Future<bool> isFirstTimeLogin() async {
//   try {
//     final result = sharedPreferences.getBool(kIsFirstTimeLoginKey);
//     /*if the user opened the app before it will be false
//       if it's his first time using the app it will be true by default */
//     return result ?? true;
//   } catch (e) {
//    throw CacheException(message: e.toString(), statusCode: kCacheStatusCode);
//   }
// }
//
// @override
// Future<void> cacheFirstTimeLogin() async {
//   try {
//     await sharedPreferences.setBool(kIsFirstTimeLoginKey, false);
//   } catch (e) {
//    throw CacheException(message: e.toString(), statusCode: kCacheStatusCode);
//   }
// }
// }
