import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
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

  const UserEntity.test()
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
  // 'displayName: $displayName, '
  // 'email: $email, '
  // 'isEmailVerified: $emailVerified, '
  // 'isAnonymous: $isAnonymous, '
  // 'metadata: $metadata, '
  // 'phoneNumber: $phoneNumber, '
  // 'photoURL: $photoURL, '
  // 'providerData, $providerData, '
  // 'refreshToken: $refreshToken, '
  // 'tenantId: $tenantId, '
  // 'uid: $uid)';
  @override
  List<Object?> get props => [
        uid,
        email,
        photoURL,
        bio,
        points,
        displayName,
        groupIds.length,
        enrolledCoursesIds.length,
        following.length,
        followers.length,
      ];

  @override
  String toString() {
    return 'UserEntity{uid: $uid, email: $email, bio: $bio, points: $points, '
        'displayName: $displayName}';
  }

  UserEntity copyWith({
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
    return UserEntity(
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
