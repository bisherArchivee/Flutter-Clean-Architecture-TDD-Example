import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/failure.dart';
import 'package:education_app/feature/authentication/domain/entity/auth_user_entity.dart';
import 'package:education_app/feature/authentication/domain/repository/auth_repository.dart';
import 'package:education_app/feature/authentication/domain/usecase/sigin_in_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthRepository authRepository;
  late SignInUseCase signInUseCase;
  late SignInParams signInParams;
  setUp(() {
    authRepository = MockAuthRepository();
    signInUseCase = SignInUseCase(authRepository: authRepository);
    signInParams = const SignInParams.test();
  });

  test(
      'should call [authRepository.sigIn()] and return the Right on success 🟢',
      () async {
    //Arrange
    when(
      () => authRepository.sigIn(
        email: signInParams.email,
        password: signInParams.password,
      ),
    ).thenAnswer((invocation) async => const Right(UserEntity.test()));
    //Act
    final result = await signInUseCase(params: signInParams);
    //Assert
    expect(result, const Right<void, UserEntity>(UserEntity.test()));
    // expect(result, const Right<void, UserEntity>(UserEntity.test()));

    verify(
      () => authRepository.sigIn(
        email: signInParams.email,
        password: signInParams.password,
      ),
    ).called(1);

    verifyNoMoreInteractions(authRepository);
  });

  //The Red Phase 🔴----------------------
  const dataFailure = Left<Failure, UserEntity>(
    ConnectionFailure(
      message: 'issue with DB caching',
      // statusCode: kConnectionStatusCode,
    ),
  );

  test(
      'should call [authRepository.sigIn()]'
      ' and should return the Left on connection Failure 🔴', () async {
    {
      //Arrange
      when(
        () => authRepository.sigIn(
          email: signInParams.email,
          password: signInParams.password,
        ),
      ).thenAnswer((_) async => dataFailure);
      //Act
      final result = await signInUseCase(params: signInParams);
      //Assert
      expect(result, dataFailure);

      verify(
        () => authRepository.sigIn(
          email: signInParams.email,
          password: signInParams.password,
        ),
      ).called(1);

      verifyNoMoreInteractions(authRepository);
    }
  });
}
