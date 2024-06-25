// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user_mapper.dart';

// **************************************************************************
// MapperGenerator
// **************************************************************************

class AuthUserMapperImpl extends AuthUserMapper {
  AuthUserMapperImpl() : super();

  @override
  UserEntity getUserEntityFromModel(UserModel model) {
    final userentity = UserEntity(
      uid: model.uid,
      email: model.email,
      points: model.points,
      displayName: model.displayName,
      groupIds: model.groupIds.map((e) => e).toList(),
      enrolledCoursesIds: model.enrolledCoursesIds.map((e) => e).toList(),
      following: model.following.map((e) => e).toList(),
      followers: model.followers.map((e) => e).toList(),
      photoURL: model.photoURL,
      bio: model.bio,
    );
    return userentity;
  }

  @override
  UserModel getUserModelFromEntity(UserEntity entity) {
    final usermodel = UserModel(
      uid: entity.uid,
      email: entity.email,
      points: entity.points,
      displayName: entity.displayName,
      groupIds: entity.groupIds.map((e) => e).toList(),
      enrolledCoursesIds: entity.enrolledCoursesIds.map((e) => e).toList(),
      following: entity.following.map((e) => e).toList(),
      followers: entity.followers.map((e) => e).toList(),
      photoURL: entity.photoURL,
      bio: entity.bio,
    );
    return usermodel;
  }
}
