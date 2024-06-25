import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/exception.dart';
import 'package:education_app/core/app/errors/failure.dart';
import 'package:education_app/core/common/constant/constants.dart';
import 'package:education_app/core/common/feature/sharedPreferences/data/datasource/local/sharedPreferences_local_datasource.dart';
import 'package:education_app/core/common/feature/sharedPreferences/data/repository/sharedPreferences_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'sharedPreferences_local_datasource.mock.dart';

void main() {
  group('SharedPreferences Feature', () {
    group('data/repository/SharedPreferencesRepositoryImpl', () {
      // late SharedPreferences sharedPreferences;
      late SharedPreferencesLocalDataSource sharedPreferencesLocalDataSource;
      late SharedPreferencesRepositoryImpl sharedPreferencesRepositoryImpl;
      setUp(() {
        // sharedPreferences = MockSharedPreferences();
        sharedPreferencesLocalDataSource =
            MockSharedPreferencesLocalDataSource();
        sharedPreferencesRepositoryImpl = SharedPreferencesRepositoryImpl(
          splashLocalDataSource: sharedPreferencesLocalDataSource,
        );
      });

      /*--------------------------------*/
      test('🟢 getString Success Scenario', () async {
        //Arrange
        when(() => sharedPreferencesLocalDataSource.getString('key'))
            .thenAnswer((invocation) async => <String, String>{'key': 'key'});
        //Act
        final result = await sharedPreferencesRepositoryImpl
            .getString('key'); // Use 'key' here
        //Assert
        expect(
          result.toString(),
          const Right<CacheFailure, Map<String, String>>({'key': 'key'})
              .toString(),
        );

        //Verify
        verify(() => sharedPreferencesLocalDataSource.getString('key'))
            .called(1); // Use 'key' here
        verifyNoMoreInteractions(sharedPreferencesLocalDataSource);
      });
      test('🔴 getString Failure Scenario', () async {
        //Arrange
        when(
          () => sharedPreferencesLocalDataSource.getString('key'),
        ).thenThrow(
          const CacheException(
            message: 'Insufficient storage',
            statusCode: kCacheStatusCode,
          ),
        );
        //Act
        final result = await sharedPreferencesRepositoryImpl.getString('key');
        //Assert
        expect(
          result,
          isA<Left<Failure, Map<String, String>>>(),
        );
        //Verify
        verify(
          () => sharedPreferencesLocalDataSource.getString('key'),
        ).called(1);
        verifyNoMoreInteractions(sharedPreferencesLocalDataSource);
      });

      /*--------------------------------*/
      test('🟢 setString Success Scenario', () async {
        //Arrange
        when(
          () => sharedPreferencesLocalDataSource.setString(
            key: 'key',
            value: 'key',
          ),
        ).thenAnswer((invocation) async => <String, String>{'key': 'key'});
        //Act
        final result = await sharedPreferencesRepositoryImpl.setString(
          key: 'key',
          value: 'key',
        ); // Use 'key' here
        //Assert
        expect(
          result,
          const Right<void, void>(null),
        );

        //Verify
        verify(
          () => sharedPreferencesLocalDataSource.setString(
            key: 'key',
            value: 'key',
          ),
        ).called(1); // Use 'key' here
        verifyNoMoreInteractions(sharedPreferencesLocalDataSource);
      });
      test('🔴 setString Failure Scenario', () async {
        //Arrange
        when(
          () => sharedPreferencesLocalDataSource.setString(
            key: 'key',
            value: 'key',
          ),
        ).thenThrow(
          const CacheException(
            message: 'Insufficient storage',
            statusCode: kCacheStatusCode,
          ),
        );
        //Act
        final result = await sharedPreferencesRepositoryImpl.setString(
          key: 'key',
          value: 'key',
        );
        //Assert
        expect(
          result,
          isA<Left<Failure, void>>(),
        );
        //Verify
        verify(
          () => sharedPreferencesLocalDataSource.setString(
            key: 'key',
            value: 'key',
          ),
        ).called(1);
        verifyNoMoreInteractions(sharedPreferencesLocalDataSource);
      });

      /*--------------------------------*/
      test('🟢 getStringList Success Scenario', () async {
        //Arrange
        when(() => sharedPreferencesLocalDataSource.getStringList('key'))
            .thenAnswer(
          (invocation) async => <String, List<String>>{
            'key': ['key'],
          },
        );
        //Act
        final result = await sharedPreferencesRepositoryImpl
            .getStringList('key'); // Use 'key' here
        //Assert
        expect(
          result.toString(),
          const Right<CacheFailure, Map<String, List<String>>>({
            'key': ['key'],
          }).toString(),
        );

        //Verify
        verify(() => sharedPreferencesLocalDataSource.getStringList('key'))
            .called(1); // Use 'key' here
        verifyNoMoreInteractions(sharedPreferencesLocalDataSource);
      });
      test('🔴 getStringList Failure Scenario', () async {
        //Arrange
        when(
          () => sharedPreferencesLocalDataSource.getStringList('key'),
        ).thenThrow(
          const CacheException(
            message: 'Insufficient storage',
            statusCode: kCacheStatusCode,
          ),
        );
        //Act
        final result =
            await sharedPreferencesRepositoryImpl.getStringList('key');
        //Assert
        expect(
          result,
          isA<Left<Failure, Map<String, List<String>>>>(),
        );
        //Verify
        verify(
          () => sharedPreferencesLocalDataSource.getStringList('key'),
        ).called(1);
        verifyNoMoreInteractions(sharedPreferencesLocalDataSource);
      });
      /*--------------------------------*/
      test('🟢 setStringList Success Scenario', () async {
        //Arrange
        when(
          () => sharedPreferencesLocalDataSource.setStringList(
            key: 'key',
            value: ['key'],
          ),
        ).thenAnswer((invocation) async => <String, List<String>>{
              'key': ['key']
            });
        //Act
        final result = await sharedPreferencesRepositoryImpl.setStringList(
          key: 'key',
          value: ['key'],
        ); // Use 'key' here
        //Assert
        expect(
          result,
          const Right<void, void>(null),
        );

        //Verify
        verify(
          () => sharedPreferencesLocalDataSource.setStringList(
            key: 'key',
            value: ['key'],
          ),
        ).called(1); // Use 'key' here
        verifyNoMoreInteractions(sharedPreferencesLocalDataSource);
      });
      test('🔴 setStringList Failure Scenario', () async {
        //Arrange
        when(
          () => sharedPreferencesLocalDataSource.setStringList(
            key: 'key',
            value: ['key'],
          ),
        ).thenThrow(
          const CacheException(
            message: 'Insufficient storage',
            statusCode: kCacheStatusCode,
          ),
        );
        //Act
        final result = await sharedPreferencesRepositoryImpl.setStringList(
          key: 'key',
          value: ['key'],
        );
        //Assert
        expect(
          result,
          isA<Left<Failure, void>>(),
        );
        //Verify
        verify(
          () => sharedPreferencesLocalDataSource.setStringList(
            key: 'key',
            value: ['key'],
          ),
        ).called(1);
        verifyNoMoreInteractions(sharedPreferencesLocalDataSource);
      });

      /*--------------------------------*/
      test('🟢 getBool Success Scenario', () async {
        //Arrange
        when(() => sharedPreferencesLocalDataSource.getBool('key'))
            .thenAnswer((invocation) async => <String, bool>{'key': false});
        //Act
        final result = await sharedPreferencesRepositoryImpl
            .getBool('key'); // Use 'key' here
        //Assert
        expect(
          result.toString(),
          const Right<CacheFailure, Map<String, bool>>({'key': false})
              .toString(),
        );

        //Verify
        verify(() => sharedPreferencesLocalDataSource.getBool('key'))
            .called(1); // Use 'key' here
        verifyNoMoreInteractions(sharedPreferencesLocalDataSource);
      });
      test('🔴 getBool Failure Scenario', () async {
        //Arrange
        when(
          () => sharedPreferencesLocalDataSource.getBool('key'),
        ).thenThrow(
          const CacheException(
            message: 'Insufficient storage',
            statusCode: kCacheStatusCode,
          ),
        );
        //Act
        final result = await sharedPreferencesRepositoryImpl.getBool('key');
        //Assert
        expect(
          result,
          isA<Left<Failure, Map<String, bool>>>(),
        );
        //Verify
        verify(
          () => sharedPreferencesLocalDataSource.getBool('key'),
        ).called(1);
        verifyNoMoreInteractions(sharedPreferencesLocalDataSource);
      });
      /*--------------------------------*/
      test('🟢 setBool Success Scenario', () async {
        //Arrange
        when(
          () => sharedPreferencesLocalDataSource.setBool(
            key: 'key',
            value: false,
          ),
        ).thenAnswer((invocation) async => <String, bool>{'key': false});
        //Act
        final result = await sharedPreferencesRepositoryImpl.setBool(
          key: 'key',
          value: false,
        ); // Use 'key' here
        //Assert
        expect(
          result,
          const Right<void, void>(null),
        );

        //Verify
        verify(
          () => sharedPreferencesLocalDataSource.setBool(
            key: 'key',
            value: false,
          ),
        ).called(1); // Use 'key' here
        verifyNoMoreInteractions(sharedPreferencesLocalDataSource);
      });
      test('🔴 setBool Failure Scenario', () async {
        //Arrange
        when(
          () => sharedPreferencesLocalDataSource.setBool(
            key: 'key',
            value: false,
          ),
        ).thenThrow(
          const CacheException(
            message: 'Insufficient storage',
            statusCode: kCacheStatusCode,
          ),
        );
        //Act
        final result = await sharedPreferencesRepositoryImpl.setBool(
          key: 'key',
          value: false,
        );
        //Assert
        expect(
          result,
          isA<Left<Failure, void>>(),
        );
        //Verify
        verify(
          () => sharedPreferencesLocalDataSource.setBool(
            key: 'key',
            value: false,
          ),
        ).called(1);
        verifyNoMoreInteractions(sharedPreferencesLocalDataSource);
      });
    });
  });
}

// /*--------------------------------*/
// test('🟢 isDarkTheme Success Scenario', () async {
//   //Arrange
//   when(
//     () => splashLocalDataSource.isDarkTheme(),
//   ).thenAnswer((invocation) async => true);
//   //Act
//   final result = await splashRepositoryImpl.isDarkTheme();
//   //Assert
//   expect(result, equals(const Right<void, bool>(true)));
// });
// test('🔴 isDarkTheme Failure Scenario', () async {
//   //Arrange
//   when(
//     () => splashLocalDataSource.isDarkTheme(),
//   ).thenThrow(
//     const CacheException(
//       message: 'Insufficient storage',
//       statusCode: kCacheStatusCode,
//     ),
//   );
//   //Act
//   final result = await splashRepositoryImpl.isDarkTheme();
//   //Assert
//   expect(
//     result,
//     equals(
//       const Left<CacheFailure, dynamic>(
//         CacheFailure(
//             message: 'Insufficient storage',
//             statusCode: kCacheStatusCode),
//       ),
//     ),
//   );
//   //Verify
//   verify(
//     () => splashLocalDataSource.isDarkTheme(),
//   ).called(1);
//   verifyNoMoreInteractions(splashLocalDataSource);
// });
//
//     /*--------------------------------*/
//     test('🟢 isFirstTimeLogin Success Scenario', () async {
//       //Arrange
//       when(
//         () => splashLocalDataSource.isFirstTimeLogin(),
//       ).thenAnswer((invocation) async => true);
//       //Act
//       final result = await splashRepositoryImpl.isFirstTimeLogin();
//       //Assert
//       expect(result, equals(const Right<void, bool>(true)));
//       //Verify
//       verify(
//         () => splashLocalDataSource.isFirstTimeLogin(),
//       ).called(1);
//       verifyNoMoreInteractions(splashLocalDataSource);
//     });
//     test('🔴 isFirstTimeLogin Failure Scenario', () async {
//       //Arrange
//       when(
//         () => splashLocalDataSource.isFirstTimeLogin(),
//       ).thenThrow(
//         const CacheException(
//           message: 'Insufficient storage',
//           statusCode: kCacheStatusCode,
//         ),
//       );
//       //Act
//       final result = await splashRepositoryImpl.isFirstTimeLogin();
//       //Assert
//       expect(
//         result,
//         equals(
//           const Left<CacheFailure, dynamic>(
//             CacheFailure(
//                 message: 'Insufficient storage',
//                 statusCode: kCacheStatusCode),
//           ),
//         ),
//       );
//       //Verify
//       verify(
//         () => splashLocalDataSource.isFirstTimeLogin(),
//       ).called(1);
//       verifyNoMoreInteractions(splashLocalDataSource);
//     });
