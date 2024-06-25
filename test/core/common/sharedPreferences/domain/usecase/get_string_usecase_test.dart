import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/failure.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/repository/sharedPreferences_repository.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/get_string_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'sharedPreferences_repository.mock.dart';

void main() {
  group('SharedPreferences Feature', () {
    late SharedPreferencesRepository sharedPreferencesRepository;
    late GetStringUseCase getStringUseCase;
    setUp(
      () {
        sharedPreferencesRepository = MockSharedPreferencesRepository();
        getStringUseCase = GetStringUseCase(
            sharedPreferencesRepository: sharedPreferencesRepository);
      },
    );

    group('domain/usecase', () {
      test(
          '🟢 GetString Success Scenario '
          'should call [sharedPreferencesRepository.getString()] '
          'and should return the right data successfully ', () async {
        //Arrange
        when(() => sharedPreferencesRepository.getString('key')).thenAnswer(
          (invocation) async => const Right({'key': 'key'}),
        );
        //Act
        final result = await getStringUseCase(params: 'key');
        //Assert
        expect(
          result,
          equals(const Right<void, Map<String, String>>({'key': 'key'})),
        );
        //Verify
        verify(
          () => sharedPreferencesRepository.getString('key'),
        ).called(1);
        verifyNoMoreInteractions(sharedPreferencesRepository);
      });

      const dataFailure = Left<Failure, Map<String, String>>(
        CacheFailure(message: 'issue with Shared Preference caching'),
      );

      test(
          '🔴 GetString Failure Scenario '
          'should call [sharedPreferencesRepository.getString()] '
          'and should return CacheFailure if there"s" an issue with caching',
          () async {
        //Arrange
        when(
          () => sharedPreferencesRepository.getString('key'),
        ).thenAnswer(
          (invocation) async => dataFailure,
        );
        //Act
        final result = await getStringUseCase(params: 'key');

        //Assert
        expect(result, equals(dataFailure));

        //Verify
        verify(
          () => sharedPreferencesRepository.getString('key'),
        ).called(1);
        verifyNoMoreInteractions(sharedPreferencesRepository);
      });
    });
  });
}
