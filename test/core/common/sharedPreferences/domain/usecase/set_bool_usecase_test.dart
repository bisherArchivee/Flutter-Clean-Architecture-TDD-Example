import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/failure.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/repository/sharedPreferences_repository.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/set_bool_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'sharedPreferences_repository.mock.dart';

void main() {
  group('SharedPreferences Feature', () {
    late SharedPreferencesRepository sharedPreferencesRepository;
    late SetBoolUseCase setBoolUseCase;
    setUp(
      () {
        sharedPreferencesRepository = MockSharedPreferencesRepository();
        setBoolUseCase = SetBoolUseCase(
          sharedPreferencesRepository: sharedPreferencesRepository,
        );
      },
    );

    group('domain/usecase', () {
      test(
          '🟢 SetBool Success Scenario '
          'should call [sharedPreferencesRepository.setBool()] '
          'and should return the right data successfully ', () async {
        //Arrange
        when(() =>
                sharedPreferencesRepository.setBool(key: 'key', value: false))
            .thenAnswer(
          (invocation) async => const Right({'key': false}),
        );
        //Act
        final result = await setBoolUseCase(params: {'key': false});
        //Assert
        expect(
          result,
          equals(const Right<void, Map<String, bool>>({'key': false})),
        );
        //Verify
        verify(
          () => sharedPreferencesRepository.setBool(key: 'key', value: false),
        ).called(1);
        verifyNoMoreInteractions(sharedPreferencesRepository);
      });

      const dataFailure = Left<Failure, Map<String, bool>>(
        CacheFailure(message: 'issue with Shared Preference caching'),
      );

      test(
          '🔴 SetBool Failure Scenario '
          'should call [sharedPreferencesRepository.setBool()] '
          'and should return CacheFailure if there"s" an issue with caching',
          () async {
        //Arrange
        when(
          () => sharedPreferencesRepository.setBool(key: 'key', value: false),
        ).thenAnswer(
          (invocation) async => dataFailure,
        );
        //Act
        final result = await setBoolUseCase(params: {'key': false});

        //Assert
        expect(result, equals(dataFailure));

        //Verify
        verify(
          () => sharedPreferencesRepository.setBool(key: 'key', value: false),
        ).called(1);
        verifyNoMoreInteractions(sharedPreferencesRepository);
      });
    });
  });
}
