import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/failure.dart';
import 'package:education_app/core/app/usecases/usecase.dart';
import 'package:education_app/feature/authentication/domain/repository/auth_repository.dart';

class CacheLogInTypeUseCase
    extends UseCaseHasParams<Either<Failure, void>, String> {
  CacheLogInTypeUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  @override
  Future<Either<Failure, void>> call({required String params}) {
    return _authRepository.cacheLogInType(logInType: params);
  }
}
