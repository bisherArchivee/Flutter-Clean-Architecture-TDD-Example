import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/failure.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/repository/sharedPreferences_repository.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/set_string_list_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'sharedPreferences_repository.mock.dart';

void main() {
  group('SharedPreferences Feature', () {
    late SharedPreferencesRepository sharedPreferencesRepository;
    late SetStringListUseCase setStringListUseCase;
    setUp(
      () {
        sharedPreferencesRepository = MockSharedPreferencesRepository();
        setStringListUseCase = SetStringListUseCase(
          sharedPreferencesRepository: sharedPreferencesRepository,
        );
      },
    );

    group('domain/usecase', () {
      test(
          '🟢 SetString Success Scenario '
          'should call [sharedPreferencesRepository.setStringList()] '
          'and should return the right data successfully ', () async {
        //Arrange
        when(
          () => sharedPreferencesRepository
              .setStringList(key: 'key', value: ['key']),
        ).thenAnswer(
          (invocation) async => const Right({'key': ['key']}),
        );
        //Act
        final result = await setStringListUseCase(params: {
          'key': ['key']
        });
        //Assert
        expect(
          result.toString(),
          equals(const Right<void, Map<String, List<String>>>({
            'key': ['key']
          }).toString()),
        );
        //Verify
        verify(
          () => sharedPreferencesRepository
              .setStringList(key: 'key', value: ['key']),
        ).called(1);
        verifyNoMoreInteractions(sharedPreferencesRepository);
      });

      const dataFailure = Left<Failure, Map<String, List<String>>>(
        CacheFailure(message: 'issue with Shared Preference caching'),
      );

      test(
          '🔴 SetString Failure Scenario '
          'should call [sharedPreferencesRepository.setStringList()] '
          'and should return CacheFailure if there"s" an issue with caching',
          () async {
        //Arrange
        when(
          () => sharedPreferencesRepository
              .setStringList(key: 'key', value: ['key']),
        ).thenAnswer(
          (invocation) async => dataFailure,
        );
        //Act
        final result = await setStringListUseCase(params: {
          'key': ['key']
        });

        //Assert
        expect(result, equals(dataFailure));

        //Verify
        verify(
          () => sharedPreferencesRepository
              .setStringList(key: 'key', value: ['key']),
        ).called(1);
        verifyNoMoreInteractions(sharedPreferencesRepository);
      });
    });
  });
}
