import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/failure.dart';
import 'package:education_app/core/common/enum/update_user_enum.dart';
import 'package:education_app/feature/authentication/domain/repository/auth_repository.dart';
import 'package:education_app/feature/authentication/domain/usecase/update_user_data_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthRepository authRepository;
  late UpdateUserDataUseCase updateUserDataUseCase;
  late UpdateUserParams updateUserParams;
  // late UpdateUserAction updateUserAction;

  setUp(() {
    authRepository = MockAuthRepository();
    updateUserDataUseCase =
        UpdateUserDataUseCase(authRepository: authRepository);
    updateUserParams = const UpdateUserParams(
      action: UpdateUserActionEnum.displayName,
      userData: '_name',
    );
  });
  test(
      'should call [authRepository.updateUserData()]'
      ' and should return the Right on success 🟢', () async {
    //Arrange
    when(
      () => authRepository.updateUserData(
        action: updateUserParams.action,
        userData: updateUserParams.userData,
      ),
    ).thenAnswer(
      (invocation) async => const Right(null),
    );
    //Act
    final result = await updateUserDataUseCase(params: updateUserParams);

    //Assert
    expect(result, const Right<void, void>(null));
    verify(
      () => authRepository.updateUserData(
        action: updateUserParams.action,
        userData: updateUserParams.userData,
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
      'should call [authRepository.updateUserData()]'
      ' and should return the Left on connection Failure 🔴', () async {
    {
      //Arrange
      when(
        () => authRepository.updateUserData(
          action: updateUserParams.action,
          userData: updateUserParams.userData,
        ),
      ).thenAnswer(
        (invocation) async => dataFailure,
      );
      //Act
      final result = await updateUserDataUseCase(params: updateUserParams);

      //Assert
      expect(result, dataFailure);
      verify(
        () => authRepository.updateUserData(
          action: updateUserParams.action,
          userData: updateUserParams.userData,
        ),
      ).called(1);
      verifyNoMoreInteractions(authRepository);
    }
  });
}
