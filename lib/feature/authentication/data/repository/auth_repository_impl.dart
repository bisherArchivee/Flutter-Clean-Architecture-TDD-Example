import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/exception.dart';
import 'package:education_app/core/app/errors/failure.dart';
import 'package:education_app/core/common/enum/update_user_enum.dart';
import 'package:education_app/feature/authentication/data/datasource/local/auth_local_data_source.dart';
import 'package:education_app/feature/authentication/data/datasource/remote/auth_remote_data_source.dart';
import 'package:education_app/feature/authentication/mapper/auth_user_mapper.dart';
import 'package:education_app/feature/authentication/domain/entity/auth_user_entity.dart';
import 'package:education_app/feature/authentication/domain/repository/auth_repository.dart';

class AuthenticationRepositoryImpl implements AuthRepository {
  AuthenticationRepositoryImpl({
    required AuthRemoteDataSource authRemoteDataSource,
    required AuthLocalDataSource authLocalDataSource,
  })  : _authRemoteDataSource = authRemoteDataSource,
        _authLocalDataSource = authLocalDataSource;

  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  @override
  Future<Either<Failure, void>> forgotPassword({required String email}) async {
    try {
      await _authRemoteDataSource.forgetPassword(email: email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> sigIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authRemoteDataSource.signIn(
        email: email,
        password: password,
      );
      return Right(AuthUserMapperImpl().getUserEntityFromModel(result));
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> signup({
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      await _authRemoteDataSource.signUp(
        email: email,
        fullName: fullName,
        password: password,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserData({
    required UpdateUserActionEnum action,
    required dynamic userData,
  }) async {
    try {
      await _authRemoteDataSource.updateUserData(
        action: action,
        userData: userData,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> cacheLogInType(
      {required String logInType}) async {
    try {
      await _authLocalDataSource.cacheLogInType(loginType: logInType);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
