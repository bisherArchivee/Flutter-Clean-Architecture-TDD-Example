import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/failure.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/repository/sharedPreferences_repository.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/get_string_list_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'sharedPreferences_repository.mock.dart';

void main() {
  group('SharedPreferences Feature', () {
    late SharedPreferencesRepository sharedPreferencesRepository;
    late GetStringListUseCase getStringUseCase;
    setUp(
      () {
        sharedPreferencesRepository = MockSharedPreferencesRepository();
        getStringUseCase = GetStringListUseCase(
          sharedPreferencesRepository: sharedPreferencesRepository,
        );
      },
    );

    group('domain/usecase', () {
      test(
          '🟢 GetStringList Success Scenario '
          'should call [sharedPreferencesRepository.getStringList()] '
          'and should return the right data successfully ', () async {
        //Arrange
        when(() => sharedPreferencesRepository.getStringList('key')).thenAnswer(
          (invocation) async => const Right({
            'key': ['key'],
          }),
        );
        //Act
        final result = await getStringUseCase(params: 'key');
        //Assert
        expect(
          result,
          equals(
            const Right<void, Map<String, List<String>>>({
              'key': ['key'],
            }),
          ),
        );
        //Verify
        verify(
          () => sharedPreferencesRepository.getStringList('key'),
        ).called(1);
        verifyNoMoreInteractions(sharedPreferencesRepository);
      });

      const dataFailure = Left<Failure, Map<String, List<String>>>(
        CacheFailure(message: 'issue with Shared Preference caching'),
      );

      test(
          '🔴 GetStringList Failure Scenario '
          'should call [sharedPreferencesRepository.getStringList()] '
          'and should return CacheFailure if there"s" an issue with caching',
          () async {
        //Arrange
        when(
          () => sharedPreferencesRepository.getStringList('key'),
        ).thenAnswer(
          (invocation) async => dataFailure,
        );
        //Act
        final result = await getStringUseCase(params: 'key');

        //Assert
        expect(result, equals(dataFailure));

        //Verify
        verify(
          () => sharedPreferencesRepository.getStringList('key'),
        ).called(1);
        verifyNoMoreInteractions(sharedPreferencesRepository);
      });
    });
  });
}
