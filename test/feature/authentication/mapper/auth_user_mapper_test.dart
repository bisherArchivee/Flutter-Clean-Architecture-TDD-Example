import 'package:education_app/feature/authentication/mapper/auth_user_mapper.dart';
import 'package:education_app/feature/authentication/data/model/auth_user_model.dart';
import 'package:education_app/feature/authentication/domain/entity/auth_user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const userModel = UserModel.test();
  const userEntity = UserEntity.test();
  final userMapper = AuthUserMapperImpl();
  group('UserModel from UserEntity Tests', () {
    test('should return UserModel from UserEntity successfully 🟢', () {
      //🔴Nothing To Arrange

      final userModelResult = userMapper.getUserModelFromEntity(userEntity);
      //Assert
      expect(userModelResult, userModel);
    });

    //The Red Phase 🔴----------------------
    test('should return UserModel from UserEntity on data failure 🔴', () {
      //🔴Nothing To Arrange

      final userModelResult =
          userMapper.getUserModelFromEntity(userEntity.copyWith(uid: '_empty'));
      //Assert
      expect(userModelResult, isNot(userModel));
    });
  });

  group('UserEntity from UserModel Tests', () {
    test('should return UserEntity from UserModel successfully 🟢', () {
      //🔴Nothing To Arrange

      final userModelResult = userMapper.getUserEntityFromModel(userModel);
      //Assert
      expect(userModelResult, userEntity);
    });

    //The Red Phase 🔴----------------------
    test('should return UserEntity from UserModel on data failure 🔴', () {
      //There is No Acting here
      //Arrange
      final userModelResult =
          userMapper.getUserEntityFromModel(userModel.copyWith(uid: '_empty'));
      //Assert
      expect(userModelResult, isNot(userEntity));
    });
  });
}
