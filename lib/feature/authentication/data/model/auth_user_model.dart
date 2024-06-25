import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  const UserModel({
    required this.uid,
    required this.email,
    required this.points,
    required this.displayName,
    this.groupIds = const [],
    this.enrolledCoursesIds = const [],
    this.following = const [],
    this.followers = const [],
    this.photoURL,
    this.bio,
  });

  const UserModel.test()
      : this(
          uid: '_uid',
          email: '_email',
          photoURL: '_photoURL',
          bio: '_bio',
          points: -1,
          displayName: '_displayName',
          groupIds: const [],
          enrolledCoursesIds: const [],
          following: const [],
          followers: const [],
        );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  final String uid;
  final String email;
  final String? photoURL;
  final String? bio;
  final int points;
  final String displayName;
  final List<String> groupIds;
  final List<String> enrolledCoursesIds;
  final List<String> following;
  final List<String> followers;

  @override
  List<Object?> get props => [uid, email];

  @override
  String toString() {
    return 'UserModel{uid: $uid, email: $email, bio: $bio, points: $points, '
        'displayName: $displayName}';
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? photoURL,
    String? bio,
    int? points,
    String? displayName,
    List<String>? groupIds,
    List<String>? enrolledCoursesIds,
    List<String>? following,
    List<String>? followers,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      photoURL: photoURL ?? this.photoURL,
      bio: bio ?? this.bio,
      points: points ?? this.points,
      displayName: displayName ?? this.displayName,
      groupIds: groupIds ?? this.groupIds,
      enrolledCoursesIds: enrolledCoursesIds ?? this.enrolledCoursesIds,
      following: following ?? this.following,
      followers: followers ?? this.followers,
    );
  }
}
