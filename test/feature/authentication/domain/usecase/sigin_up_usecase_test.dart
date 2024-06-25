import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/failure.dart';
import 'package:education_app/feature/authentication/domain/repository/auth_repository.dart';
import 'package:education_app/feature/authentication/domain/usecase/sigin_up_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthRepository authRepository;
  late SignUpUseCase signUpUseCase;
  late SignUpParams signUpParams;

  setUp(() {
    authRepository = MockAuthRepository();
    signUpUseCase = SignUpUseCase(authRepository: authRepository);
    signUpParams = const SignUpParams.test();
  });
  test('should call authRepository.signUp()', () async {
    //Arrange
    when(
      () => authRepository.signup(
        email: signUpParams.email,
        fullName: signUpParams.fullName,
        password: signUpParams.password,
      ),
    ).thenAnswer(
      (
        invocation,
      ) async =>
          const Right(null),
    );

    //Act
    final result = await signUpUseCase(params: signUpParams);

    //Assert
    expect(result, const Right<void, void>(null));

    verify(
      () => authRepository.signup(
        email: signUpParams.email,
        fullName: signUpParams.fullName,
        password: signUpParams.password,
      ),
    ).called(1);
    verifyNoMoreInteractions(authRepository);
  });

  //The Red Phase 🔴----------------------
  const dataFailure = Left<Failure, void>(
    ConnectionFailure(
      message: 'issue with DB caching',
      // statusCode: kConnectionStatusCode,
    ),
  );

  test(
      'should call [authRepository.signUp()]'
      ' and should return the Left on connection Failure 🔴', () async {
    {
      //Arrange
      when(
        () => authRepository.signup(
          email: signUpParams.email,
          fullName: signUpParams.fullName,
          password: signUpParams.password,
        ),
      ).thenAnswer(
        (
          invocation,
        ) async =>
            dataFailure,
      );

      //Act
      final result = await signUpUseCase(params: signUpParams);

      //Assert
      expect(result, dataFailure);

      verify(
        () => authRepository.signup(
          email: signUpParams.email,
          fullName: signUpParams.fullName,
          password: signUpParams.password,
        ),
      ).called(1);
      verifyNoMoreInteractions(authRepository);
    }
  });
}
