import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/failure.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/get_bool_usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/get_string_list_usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/get_string_usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/set_bool_usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/set_string_list_usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/set_string_usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/presentation/cubit/sharedPreferences_cubit.dart';
import 'package:education_app/core/common/feature/sharedPreferences/presentation/cubit/sharedPreferences_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'sharedPreferences_usecases.mock.dart';

void main() {
  group('SharedPreferences Common', () {
    group('presentation/cubit/SharedPreferencesCubit', () {
      late SetBoolUseCase setBoolUseCase;
      late SetStringUseCase setStringUseCase;
      late SetStringListUseCase setStringListUseCase;

      late GetStringUseCase getStringUseCase;
      late GetBoolUseCase getBoolUseCase;
      late GetStringListUseCase getStringListUseCase;
      late SharedPreferencesCubitImpl sharedPreferencesCubit;

      setUp(
        () {
          setBoolUseCase = MockSetBoolUseCase();
          setStringUseCase = MockSetStringUseCase();
          setStringListUseCase = MockSetStringListUseCase();

          getStringUseCase = MockGetStringUseCase();
          getBoolUseCase = MockGetBoolUseCase();
          getStringListUseCase = MockGetStringListUseCase();
          sharedPreferencesCubit = SharedPreferencesCubitImpl(
            setBoolUseCase: setBoolUseCase,
            setStringUseCase: setStringUseCase,
            setStringListUseCase: setStringListUseCase,
            getBoolUseCase: getBoolUseCase,
            getStringUseCase: getStringUseCase,
            getStringListUseCase: getStringListUseCase,
          );
        },
      );
      test(
        '🔵 setBoolUseCase Initial State Scenario',
        () {
          expect(sharedPreferencesCubit.state, SharedPreferencesInitialState());
        },
      );
      group(
        'Bool Cases',
        () {
          /*-----------------------------------*/
          blocTest<SharedPreferencesCubitImpl, SharedPreferencesState>(
            '🟢 setBoolUseCase Success Scenario',
            build: () {
              when(() => setBoolUseCase(params: {'key': false})).thenAnswer(
                (invocation) async => const Right(null),
              );
              return sharedPreferencesCubit;
            },
            act: (onBoardingCubit) =>
                onBoardingCubit.setBoolCubit({'key': false}),
            expect: () => [
              const SetBoolLoadingState(key: 'key'),
              const SetBoolSuccessState(),
            ],
            verify: (_) {
              verify(() => setBoolUseCase(params: {'key': false})).called(1);
              verifyNoMoreInteractions(setBoolUseCase);
            },
          );

          blocTest<SharedPreferencesCubitImpl, SharedPreferencesState>(
            '🔴 setBoolUseCase Failure Scenario',
            build: () {
              when(() => setBoolUseCase(params: {'key': false})).thenAnswer(
                (invocation) async =>
                    const Left(CacheFailure(message: 'failure.message')),
              );
              return sharedPreferencesCubit;
            },
            act: (onBoardingCubit) =>
                onBoardingCubit.setBoolCubit({'key': false}),
            expect: () => [
              const SetBoolLoadingState(key: 'key'),
              const SharedPreferencesErrorState(
                  errorMessage: 'failure.message'),
            ],
            verify: (_) {
              verify(() => setBoolUseCase(params: {'key': false})).called(1);
              verifyNoMoreInteractions(setBoolUseCase);
            },
          );

          /*-----------------------------------*/
          blocTest<SharedPreferencesCubitImpl, SharedPreferencesState>(
            '🟢 getBoolUseCase Success Scenario',
            build: () {
              when(() => getBoolUseCase(params: 'key')).thenAnswer(
                (invocation) async => const Right({'key': false}),
              );
              return sharedPreferencesCubit;
            },
            act: (onBoardingCubit) => onBoardingCubit.getBoolUseCubit('key'),
            expect: () => [
              const GetBoolLoadingState(key: 'key'),
              const GetBoolSuccessState(keyValueMap: {'key': false}),
            ],
            verify: (_) {
              verify(() => getBoolUseCase(params: 'key')).called(1);
              verifyNoMoreInteractions(getBoolUseCase);
            },
          );

          blocTest<SharedPreferencesCubitImpl, SharedPreferencesState>(
            '🔴 getBoolUseCase Failure Scenario',
            build: () {
              when(() => getBoolUseCase(params: 'key')).thenAnswer(
                (invocation) async => const Left(
                  CacheFailure(message: 'CacheFailure'),
                ),
              );
              return sharedPreferencesCubit;
            },
            act: (bloc) {
              return sharedPreferencesCubit.getBoolUseCubit('key');
            },
            expect: () {
              return [
                const GetBoolLoadingState(key: 'key'),
                const SharedPreferencesErrorState(errorMessage: 'CacheFailure'),
              ];
            },
            verify: (bloc) {
              verify(() => getBoolUseCase(params: 'key')).called(1);
              verifyNoMoreInteractions(getBoolUseCase);
            },
          );
        },
      );
      /*-----------------------------------*/

      group(
        'String Cases',
        () {
          /*-----------------------------------*/
          blocTest<SharedPreferencesCubitImpl, SharedPreferencesState>(
            '🟢 getStringUseCase Success Scenario',
            build: () {
              when(() => getStringUseCase(params: 'key')).thenAnswer(
                (invocation) async => const Right({'key': 'key'}),
              );
              return sharedPreferencesCubit;
            },
            act: (bloc) {
              return sharedPreferencesCubit.getStringCubit('key');
            },
            expect: () {
              return [
                const GetStringLoadingState(key: 'key'),
                const GetStringSuccessState(keyValueMap: {'key': 'key'}),
              ];
            },
            verify: (bloc) {
              verify(() => getStringUseCase(params: 'key')).called(1);
              verifyNoMoreInteractions(getStringUseCase);
            },
          );

          blocTest<SharedPreferencesCubitImpl, SharedPreferencesState>(
            '🔴 getStringUseCase Failure Scenario',
            build: () {
              when(() => getStringUseCase(params: 'key')).thenAnswer(
                (invocation) async => const Left(
                  CacheFailure(message: 'CacheFailure'),
                ),
              );
              return sharedPreferencesCubit;
            },
            act: (bloc) {
              return sharedPreferencesCubit.getStringCubit('key');
            },
            expect: () {
              return [
                const GetStringLoadingState(key: 'key'),
                const SharedPreferencesErrorState(errorMessage: 'CacheFailure'),
              ];
            },
            verify: (bloc) {
              verify(() => getStringUseCase(params: 'key')).called(1);
              verifyNoMoreInteractions(getStringUseCase);
            },
          );

          /*----------------------------------------------------------------*/
          blocTest<SharedPreferencesCubitImpl, SharedPreferencesState>(
            '🟢 setStringUseCase Success Scenario',
            build: () {
              when(() => setStringUseCase(params: {'key': 'key'})).thenAnswer(
                (invocation) async => const Right(null),
              );
              return sharedPreferencesCubit;
            },
            act: (bloc) {
              return sharedPreferencesCubit.setStringCubit({'key': 'key'});
            },
            expect: () {
              return [
                const SetStringLoadingState(key: 'key'),
                const SetStringSuccessState(),
              ];
            },
            verify: (bloc) {
              verify(() => setStringUseCase(params: {'key': 'key'})).called(1);
              verifyNoMoreInteractions(getStringListUseCase);
            },
          );

          blocTest<SharedPreferencesCubitImpl, SharedPreferencesState>(
            '🔴 setStringListUseCase Failure Scenario',
            build: () {
              when(
                () => setStringListUseCase(
                  params: {
                    'key': ['key'],
                  },
                ),
              ).thenAnswer(
                (invocation) async => const Left(
                  CacheFailure(message: 'CacheFailure'),
                ),
              );
              return sharedPreferencesCubit;
            },
            act: (bloc) {
              return sharedPreferencesCubit.setStringListCubit({
                'key': ['key'],
              });
            },
            expect: () {
              return [
                const SetStringListLoadingState(key: 'key'),
                const SharedPreferencesErrorState(errorMessage: 'CacheFailure'),
              ];
            },
            verify: (bloc) {
              verify(
                () => setStringListUseCase(
                  params: {
                    'key': ['key'],
                  },
                ),
              ).called(1);
              verifyNoMoreInteractions(getStringListUseCase);
            },
          );
        },
      );
      /*--------------------------------------------------------------*/
      group(
        'StringList Cases',
        () {
          /*--------------------------------------------------------------*/
          blocTest<SharedPreferencesCubitImpl, SharedPreferencesState>(
            '🟢 getStringListUseCase Success Scenario',
            build: () {
              when(() => getStringListUseCase(params: 'key')).thenAnswer(
                (invocation) async => const Right({
                  'key': ['key'],
                }),
              );
              return sharedPreferencesCubit;
            },
            act: (bloc) {
              return sharedPreferencesCubit.getStringListCubit('key');
            },
            expect: () {
              return [
                const GetStringListLoadingState(key: 'key'),
                const GetStringListSuccessState(
                  keyValueMap: {
                    'key': ['key'],
                  },
                ),
              ];
            },
            verify: (bloc) {
              verify(() => getStringListUseCase(params: 'key')).called(1);
              verifyNoMoreInteractions(getStringListUseCase);
            },
          );

          blocTest<SharedPreferencesCubitImpl, SharedPreferencesState>(
            '🔴 getStringListUseCase Failure Scenario',
            build: () {
              when(() => getStringListUseCase(params: 'key')).thenAnswer(
                (invocation) async => const Left(
                  CacheFailure(message: 'CacheFailure'),
                ),
              );
              return sharedPreferencesCubit;
            },
            act: (bloc) {
              return sharedPreferencesCubit.getStringListCubit('key');
            },
            expect: () {
              return [
                const GetStringListLoadingState(key: 'key'),
                const SharedPreferencesErrorState(errorMessage: 'CacheFailure'),
              ];
            },
            verify: (bloc) {
              verify(() => getStringListUseCase(params: 'key')).called(1);
              verifyNoMoreInteractions(getStringUseCase);
            },
          );

          /*----------------------------------------------------------------*/
          blocTest<SharedPreferencesCubitImpl, SharedPreferencesState>(
            '🟢 setStringListUseCase Success Scenario',
            build: () {
              when(
                () => setStringListUseCase(
                  params: {
                    'key': ['key']
                  },
                ),
              ).thenAnswer(
                (invocation) async => const Right(null),
              );
              return sharedPreferencesCubit;
            },
            act: (bloc) {
              return sharedPreferencesCubit.setStringListCubit({
                'key': ['key'],
              });
            },
            expect: () {
              return [
                const SetStringListLoadingState(key: 'key'),
                const SetStringListSuccessState(),
              ];
            },
            verify: (bloc) {
              verify(
                () => setStringListUseCase(
                  params: {
                    'key': ['key'],
                  },
                ),
              ).called(1);
              verifyNoMoreInteractions(setStringListUseCase);
            },
          );

          blocTest<SharedPreferencesCubitImpl, SharedPreferencesState>(
            '🔴 setStringListUseCase Failure Scenario',
            build: () {
              when(() => setStringListUseCase(params: {
                    'key': ['key']
                  })).thenAnswer(
                (invocation) async => const Left(
                  CacheFailure(message: 'CacheFailure'),
                ),
              );
              return sharedPreferencesCubit;
            },
            act: (bloc) {
              return sharedPreferencesCubit.setStringListCubit({
                'key': ['key']
              });
            },
            expect: () {
              return [
                const SetStringListLoadingState(key: 'key'),
                const SharedPreferencesErrorState(errorMessage: 'CacheFailure'),
              ];
            },
            verify: (bloc) {
              verify(
                () => setStringListUseCase(
                  params: {
                    'key': ['key'],
                  },
                ),
              ).called(1);
              verifyNoMoreInteractions(setStringListUseCase);
            },
          );
        },
      );
    });
  });
}
