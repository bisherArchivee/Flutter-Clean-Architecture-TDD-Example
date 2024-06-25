import 'package:education_app/core/app/errors/exception.dart';
import 'package:education_app/core/common/feature/sharedPreferences/data/datasource/local/sharedPreferences_local_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'sharedPreferences_sharedpreferences.mock.dart';

void main() {
  group('SharedPreferences Common', () {
    group('data/datasource/local/SharedPreferencesLocalDataSource', () {
      late SharedPreferences sharedPreferences;
      late SharedPreferencesLocalDataSourceImpl splashLocalDataSourceImpl;
      setUp(
        () {
          sharedPreferences = MockSharedPreferences();
          splashLocalDataSourceImpl = SharedPreferencesLocalDataSourceImpl(
            sharedPreferences: sharedPreferences,
          );
        },
      );
      test('🟢getLoginStatus Success Scenario', () async {
        //Arrange
        when(
          () => sharedPreferences.getString('key'),
        ).thenAnswer(
          (invocation) => 'key',
        );
        //Act
        final result = await splashLocalDataSourceImpl.getString('key');
        //Assert
        expect(result, equals({'key': 'key'}));
        //Verify
        verify(
          () => sharedPreferences.getString(any()),
        ).called(1);
        verifyNoMoreInteractions(sharedPreferences);
      });
      // test('🔴getLoginStatus Failure Scenario', () async {
      //   // Arrange
      //   when(() => sharedPreferences.getString(kLoginStatusTypeKey))
      //   .thenThrow(Exception());
      //
      //   // Act
      //   final methodCall = () => splashLocalDataSourceImpl
      //   .getString(kLoginStatusTypeKey);
      //
      //   // Assert
      //   expect(methodCall, throwsA(isA<CacheException>()));
      //
      //   // Verify
      //   verify(() => sharedPreferences.getString(any())).called(1);
      //   verifyNoMoreInteractions(sharedPreferences);
      // });
      test('🔴getLoginStatus Failure Scenario', () async {
        //Arrange
        when(
          () async => sharedPreferences.getString('key'),
        ).thenThrow(
          Exception(),
        );
        //Act
        final methodCall = splashLocalDataSourceImpl.getString('key');
        //Assert
        expect(methodCall, throwsA(isA<CacheException>()));
        //Verify
        verify(
          () => sharedPreferences.getString(any()),
        ).called(1);
        verifyNoMoreInteractions(sharedPreferences);
      });

      // /*--------------------------------*/
      //
      // test('🟢isDarkTheme Success Scenario', () async {
      //   //Arrange
      //   when(
      //         () => sharedPreferences.getBool(any()),
      //   ).thenAnswer(
      //         (invocation) => true,
      //   );
      //   //Act
      //   final result = await splashLocalDataSource.isDarkTheme();
      //   //Assert
      //   expect(result, equals(true));
      //   //Verify
      //   verify(
      //         () => sharedPreferences.getBool(any()),
      //   ).called(1);
      //   verifyNoMoreInteractions(sharedPreferences);
      // });
      //
      // test('🔴isDarkTheme Failure Scenario', () async {
      //   //Arrange
      //   when(
      //         () => sharedPreferences.getBool(any()),
      //   ).thenThrow(Exception());
      //
      //   //Act
      //   final methodReference = splashLocalDataSource.isDarkTheme;
      //
      //   //Assert
      //   expect(methodReference, throwsA(isA<CacheException>()));
      //   //Verify
      //   verify(
      //         () => sharedPreferences.getBool(any()),
      //   ).called(1);
      //   verifyNoMoreInteractions(sharedPreferences);
      // });
      // /*--------------------------------*/
      //
      // test('🟢isFirstTimeLogin Success Scenario', () async {
      //   //Arrange
      //   when(
      //         () => sharedPreferences.getBool(any()),
      //   ).thenAnswer((invocation) => true);
      //
      //   //Act
      //   final result = await splashLocalDataSource.isFirstTimeLogin();
      //   //Assert
      //   expect(result, true);
      //   //Verify
      //   verify(
      //         () => sharedPreferences.getBool(any()),
      //   ).called(1);
      //   verifyNoMoreInteractions(sharedPreferences);
      // });
      //
      // test('🔴isFirstTimeLogin Failure Scenario', () async {
      //   //Arrange
      //   when(
      //         () => sharedPreferences.getBool(any()),
      //   ).thenThrow((invocation) async => Exception());
      //
      //   //Act
      //   final methodReference = splashLocalDataSource.isFirstTimeLogin;
      //   //Assert
      //   expect(methodReference, throwsA(isA<CacheException>()));
      //   //Verify
      //   verify(
      //         () => sharedPreferences.getBool(any()),
      //   ).called(1);
      //   verifyNoMoreInteractions(sharedPreferences);
      // });
    });
  });
}
