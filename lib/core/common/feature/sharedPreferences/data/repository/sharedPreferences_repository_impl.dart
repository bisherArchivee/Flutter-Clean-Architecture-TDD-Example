import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/exception.dart';
import 'package:education_app/core/app/errors/failure.dart';
import 'package:education_app/core/common/feature/sharedPreferences/data/datasource/local/sharedPreferences_local_datasource.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/repository/sharedPreferences_repository.dart';
import 'package:flutter/material.dart';

class SharedPreferencesRepositoryImpl implements SharedPreferencesRepository {
  SharedPreferencesRepositoryImpl({
    required SharedPreferencesLocalDataSource splashLocalDataSource,
  }) : _splashLocalDataSource = splashLocalDataSource;

  final SharedPreferencesLocalDataSource _splashLocalDataSource;

  @override
  Future<Either<Failure, Map<String, bool>>> getBool(String key) async {
    try {
      final result = await _splashLocalDataSource.getBool(key);
      return Right(result);
    } on CacheException catch (e) {
      debugPrint('‼️ SharedPreferencesRepositoryImpl CacheException getBool '
          'key=> $key errorMessage=> $e');
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, Map<String, double>>> getDouble(String key) async {
    try {
      final result = await _splashLocalDataSource.getDouble(key);
      return Right(result!);
    } on CacheException catch (e) {
      debugPrint('‼️ SharedPreferencesRepositoryImpl CacheException getDouble '
          'key=> $key');
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, Map<String, int>>> getInt(String key) async {
    try {
      final result = await _splashLocalDataSource.getInt(key);
      return Right(result);
    } on CacheException catch (e) {
      debugPrint('‼️ SharedPreferencesRepositoryImpl CacheException getInt '
          'key=> $key errorMessage=> $e');
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, Map<String, String>>> getString(String key) async {
    try {
      final result = await _splashLocalDataSource.getString(key);
      return Right(result);
    } on CacheException catch (e) {
      debugPrint('‼️ SharedPreferencesRepositoryImpl CacheException getString '
          'key=> $key errorMessage=> $e');
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, Map<String, List<String>>>> getStringList(
    String key,
  ) async {
    try {
      final result = await _splashLocalDataSource.getStringList(key);
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, void>> setBool({
    required String key,
    required bool value,
  }) async {
    try {
      await _splashLocalDataSource.setBool(key: key, value: value);
      return const Right(null);
    } on CacheException catch (e) {
      debugPrint('‼️ SharedPreferencesRepositoryImpl CacheException setBool '
          'key=> $key errorMessage=> $e');
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, void>> setDouble({
    required String key,
    required double value,
  }) async {
    try {
      await _splashLocalDataSource.setDouble(key: key, value: value);
      return const Right(null);
    } on CacheException catch (e) {
      debugPrint('‼️ SharedPreferencesRepositoryImpl CacheException setDouble '
          'key=> $key errorMessage=> $e');
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, void>> setInt({
    required String key,
    required int value,
  }) async {
    try {
      await _splashLocalDataSource.setInt(key: key, value: value);
      return const Right(null);
    } on CacheException catch (e) {
      debugPrint('‼️ SharedPreferencesRepositoryImpl CacheException setInt '
          'key=> $key errorMessage=> $e');
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, void>> setString({
    required String key,
    required String value,
  }) async {
    try {
      await _splashLocalDataSource.setString(key: key, value: value);
      return const Right(null);
    } on CacheException catch (e) {
      debugPrint('‼️ SharedPreferencesRepositoryImpl CacheException setString '
          'key=> $key errorMessage=> $e');
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, void>> setStringList({
    required String key,
    required List<String> value,
  }) async {
    try {
      await _splashLocalDataSource.setStringList(key: key, value: value);
      return const Right(null);
    } on CacheException catch (e) {
      debugPrint(
        '‼️ SharedPreferencesRepositoryImpl CacheException setStringList '
        'key=> $key errorMessage=> $e',
      );
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

// @override
// Future<Either<Failure, String>> getLoginStatus() async {
//   try {
//     final result = await _splashLocalDataSource.getLoginStatus();
//     return Right(result);
//   } on CacheException catch (e) {
//     return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
//   }
// }
//
// @override
// Future<Either<Failure, bool>> isDarkTheme() async {
//   try {
//     final result = await _splashLocalDataSource.isDarkTheme();
//     return Right(result);
//   } on CacheException catch (e) {
//     return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
//   }
// }
//
// @override
// Future<Either<Failure, bool>> isFirstTimeLogin() async {
//   try {
//     final result = await _splashLocalDataSource.isFirstTimeLogin();
//     return Right(result);
//   } on CacheException catch (e) {
//     return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
//   }
// }
//
// @override
// Future<Either<Failure, void>> cacheFirstTimeLogin() async {
//   try {
//     await _splashLocalDataSource.cacheFirstTimeLogin();
//     return const Right(null);
//   } on CacheException catch (e) {
//     return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
//   }
// }
}
