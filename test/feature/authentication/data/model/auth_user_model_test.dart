import 'dart:convert';

import 'package:education_app/feature/authentication/data/model/auth_user_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../data_simulator/data_reader.dart';

void main() {
  final stringDate = dataReader('user.json');
  final jsonData = jsonDecode(stringDate);
  const userModel = UserModel.test();
  final dataFailureUserModel = userModel.copyWith(uid: '_empty');

  group('fromJson  Tests', () {
    test(
        'should return a [UserModel] fromJson with the right data on Success 🟢',
        () {
      //🔴Nothing To Arrange

      if (jsonData is Map<String, dynamic>) {
        //Act
        final result = UserModel.fromJson(jsonData);

        //Assert
        expect(result, isInstanceOf<UserModel>());
        expect(result, equals(userModel));
      }
    });

    //The Exception Case 🔴----------------------
    test(
        'should return an exception when try to get [UserModel] fromJson  '
        'on data failure 🔴', () {
      //There is No Acting here

      if (jsonData is Map<String, dynamic>) {
        //Act
        const result = UserModel
            .fromJson; /*we executed the method call
             inside expect(() => result(dataFailureUserModel */

        //Assert
        expect(result, isNot(dataFailureUserModel));
        expect(
          () => result(dataFailureUserModel as Map<String, dynamic>),
          throwsA(isA<Error>()),
        );
      }
    });
  });

  group('toJson Tests', () {
    test(
        'should return a Json from [UserModel] when using toJson() '
        'with the right data on Success 🟢', () {
      //🔴Nothing To Arrange

      if (jsonData is Map<String, dynamic>) {
        //Act
        final jsonResult = userModel.toJson();

        //Assert
        expect(jsonResult, equals(jsonData));
      }
    });

    //The Exception Case 🔴----------------------
    // final dataFailure = userModel.copyWith(uid: "_empty");
    test(
        'should return an exception when try to get Json from [UserModel] '
        'when using toJson() on data failure 🔴', () {
      //🔴Nothing To Arrange

      if (jsonData is Map<String, dynamic>) {
        //Act
        final jsonResult = dataFailureUserModel.toJson();

        //Assert
        expect(jsonResult, isNot(jsonData));
      }
    });
  });

  group('copyWith Tests', () {
    test(
        'should return a copy from [UserModel] when using copyWith() '
        'with the right data on Success 🟢', () {
      //🔴Nothing To Arrange

      //Act
      final copiedModel = userModel.copyWith(uid: '2');

      //Assert
      expect(copiedModel.uid, equals('2'));
    });

    //The Exception Case 🔴----------------------
    // final dataFailure = userModel.copyWith(uid: "_empty");
    test(
        'should return an exception from [UserModel] when using copyWith() '
        'with the right data onon data failure 🔴', () {
      //🔴Nothing To Arrange

      //Act
      final copiedModel = userModel.copyWith(uid: '2');

      //Assert
      expect(copiedModel.uid, isNot('_uid'));
    });
  });
}
