import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/failure.dart';
import 'package:education_app/feature/authentication/domain/entity/auth_user_entity.dart';
import 'package:education_app/feature/authentication/domain/repository/auth_repository.dart';
import 'package:education_app/feature/authentication/domain/usecase/forgot_password_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthRepository authRepository;
  late UserEntity userEntity;
  late ForgotPasswordUseCase forgotPasswordUseCase;

  setUp(() {
    authRepository = MockAuthRepository();
    userEntity = const UserEntity.test();
    forgotPasswordUseCase =
        ForgotPasswordUseCase(authRepository: authRepository);
  });

  //The Green Phase 🟢----------------------
  test(
      'should call [authRepository.forgotPasswordUseCase()]'
      ' and should return the right data successfully 🟢', () async {
    //Arrange
    when(() => authRepository.forgotPassword(email: userEntity.email))
        .thenAnswer((invocation) async => const Right(null));

    //Act
    final result = await forgotPasswordUseCase(params: '_email');
    //Assert
    expect(result, equals(const Right<void, void>(null)));
  });

  //The Red Phase 🔴----------------------
  const dataFailure = Left<Failure, void>(
    ConnectionFailure(
      message: 'issue with DB caching',
      // statusCode: kConnectionStatusCode,
    ),
  );

  test(
      'should call [authRepository.forgotPasswordUseCase()]'
      ' and should return the Left on connection Failure 🔴', () async {
    //Arrange
    when(() => authRepository.forgotPassword(email: '_email'))
        .thenAnswer((_) async => dataFailure);
    // // Act
    final result = await forgotPasswordUseCase(params: '_email');
    // // Assert
    expect(result, equals(dataFailure));

    verify(
      () => authRepository.forgotPassword(email: '_email'),
    ).called(1);

    verifyNoMoreInteractions(authRepository);
  });
}
