import 'package:education_app/core/app/db/floor/app_database.dart';
import 'package:education_app/core/app/errors/exception.dart';
import 'package:education_app/core/common/constant/constants.dart';

abstract class LocalizationLocalDataSource {
  const LocalizationLocalDataSource();

  Future<String?> getLocal(
      {required String appLanguage, required String local});
}

// class AuthLocalDataSourceImpl extends AuthLocalDataSource {
//   AuthLocalDataSourceImpl({required SharedPreferences sharedPreferences})
//       : _sharedPreferences = sharedPreferences;
//
//   final SharedPreferences _sharedPreferences;
//
//   @override
//   Future<void> cacheLogInType({required String loginType}) async {
//     try {
//       await _sharedPreferences.setString(kLoginStatusKey, loginType);
//     } catch (e) {
//       throw CacheException(message: e.toString(), statusCode: kCacheStatusCode);
//     }
//   }
// }

class LocalizationLocalDataSourceImpl extends LocalizationLocalDataSource {
  LocalizationLocalDataSourceImpl(this._appDatabase);

  final AppDatabase _appDatabase;

  @override
  Future<String?> getLocal({
    required String appLanguage,
    required String local,
  }) async {
    try {
      final result = _appDatabase.localizationDAO.getLocal(appLanguage, local);
      // if (result == null) {
      //   return local;
      // }
      return result;
    } catch (e) {
      // TODO(Bisher): return local when null instead of left
      return throw CacheException(
          message: e.toString(), statusCode: kCacheStatusCode);
      // return local;
    }
  }
}
