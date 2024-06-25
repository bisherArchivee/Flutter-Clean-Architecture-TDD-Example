import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/failure.dart';
import 'package:education_app/core/common/enum/update_user_enum.dart';
import 'package:education_app/feature/authentication/domain/entity/auth_user_entity.dart';

abstract class AuthRepository {
  const AuthRepository();

  Future<Either<Failure, UserEntity>> sigIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> signup({
    required String email,
    required String fullName,
    required String password,
  });

  Future<Either<Failure, void>> forgotPassword({required String email});

  Future<Either<Failure, void>> updateUserData({
    required UpdateUserActionEnum action,
    required dynamic userData,
  });

  Future<Either<Failure, void>> cacheLogInType({required String logInType});

}
