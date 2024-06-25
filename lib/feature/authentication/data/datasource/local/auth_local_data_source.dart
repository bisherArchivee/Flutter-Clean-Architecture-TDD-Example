import 'package:education_app/core/app/errors/exception.dart';
import 'package:education_app/core/common/constant/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheLogInType({required String loginType});
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  @override
  Future<void> cacheLogInType({required String loginType}) async {
    try {
      await _sharedPreferences.setString(kLoginStatusTypeKey, loginType);
    } catch (e) {
      throw CacheException(message: e.toString(), statusCode: kCacheStatusCode);
    }
  }
}
