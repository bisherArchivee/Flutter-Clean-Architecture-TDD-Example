// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      points: json['points'] as int,
      displayName: json['displayName'] as String,
      groupIds: (json['groupIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      enrolledCoursesIds: (json['enrolledCoursesIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      following: (json['following'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      followers: (json['followers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      photoURL: json['photoURL'] as String?,
      bio: json['bio'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'photoURL': instance.photoURL,
      'bio': instance.bio,
      'points': instance.points,
      'displayName': instance.displayName,
      'groupIds': instance.groupIds,
      'enrolledCoursesIds': instance.enrolledCoursesIds,
      'following': instance.following,
      'followers': instance.followers,
    };
