import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/failure.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/repository/sharedPreferences_repository.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/get_bool_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'sharedPreferences_repository.mock.dart';

void main() {
  group('SharedPreferences Feature', () {
    late SharedPreferencesRepository sharedPreferencesRepository;
    late GetBoolUseCase getBoolUseCase;
    setUp(
      () {
        sharedPreferencesRepository = MockSharedPreferencesRepository();
        getBoolUseCase = GetBoolUseCase(
          sharedPreferencesRepository: sharedPreferencesRepository,
        );
      },
    );

    group('domain/usecase', () {
      test(
          '🟢 GetBool Success Scenario '
          'should call [sharedPreferencesRepository.getBool()] '
          'and should return the right data successfully ', () async {
        //Arrange
        when(() => sharedPreferencesRepository.getBool('key')).thenAnswer(
          (invocation) async => const Right({'key': false}),
        );
        //Act
        final result = await getBoolUseCase(params: 'key');
        //Assert
        expect(
          result,
          equals(const Right<void, Map<String, bool>>({'key': false})),
        );
        //Verify
        verify(
          () => sharedPreferencesRepository.getBool('key'),
        ).called(1);
        verifyNoMoreInteractions(sharedPreferencesRepository);
      });

      const dataFailure = Left<Failure, Map<String, bool>>(
        CacheFailure(message: 'issue with Shared Preference caching'),
      );

      test(
          '🔴 GetBool Failure Scenario '
          'should call [sharedPreferencesRepository.getBool()] '
          'and should return CacheFailure if there"s" an issue with caching',
          () async {
        //Arrange
        when(
          () => sharedPreferencesRepository.getBool('key'),
        ).thenAnswer(
          (invocation) async => dataFailure,
        );
        //Act
        final result = await getBoolUseCase(params: 'key');

        //Assert
        expect(result, equals(dataFailure));

        //Verify
        verify(
          () => sharedPreferencesRepository.getBool('key'),
        ).called(1);
        verifyNoMoreInteractions(sharedPreferencesRepository);
      });
    });
  });
}
