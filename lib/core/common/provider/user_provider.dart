import 'package:education_app/feature/authentication/domain/entity/auth_user_entity.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserEntity? _userEntity;

  void initUser(UserEntity? user) {
    if (_userEntity != user) _userEntity = user;
  }

  UserEntity? get userEntity => _userEntity;

  set userEntity(UserEntity? user) {
    if (_userEntity != user) {
      _userEntity = user;
      /*we need to update the ui if there is a user  data update
      but if the page in building state
      it will throw an error that's why we need to delay */
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
