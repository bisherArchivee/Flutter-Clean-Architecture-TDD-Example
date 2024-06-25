import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/failure.dart';

abstract class SharedPreferencesRepository {
  Future<Either<Failure, void>> setString({
    required String key,
    required String value,
  });

  Future<Either<Failure, void>> setBool({
    required String key,
    required bool value,
  });

  Future<Either<Failure, void>> setDouble({
    required String key,
    required double value,
  });

  Future<Either<Failure, void>> setInt({
    required String key,
    required int value,
  });

  Future<Either<Failure, void>> setStringList({
    required String key,
    required List<String> value,
  });

  Future<Either<Failure, Map<String, String>>> getString(String key);

  Future<Either<Failure, Map<String, bool>>> getBool(String key);

  Future<Either<Failure, Map<String, double>>> getDouble(String key);

  Future<Either<Failure, Map<String, int>>> getInt(String key);

  Future<Either<Failure, Map<String, List<String>>>> getStringList(String key);
// Future<Either<Failure, void>> cacheFirstTimeLogin();
//
// Future<Either<Failure, bool>> isFirstTimeLogin();
//
// Future<Either<Failure, String>> getLoginStatus();
//
// Future<Either<Failure, bool>> isDarkTheme();
}
