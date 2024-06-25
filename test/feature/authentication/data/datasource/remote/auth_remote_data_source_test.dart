import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/app/errors/exception.dart';
import 'package:education_app/core/common/constant/constants.dart';
import 'package:education_app/core/common/enum/update_user_enum.dart';
import 'package:education_app/feature/authentication/data/datasource/remote/auth_remote_data_source.dart';
import 'package:education_app/feature/authentication/data/model/auth_user_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_firebase_libraries.mock.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  late FirebaseAuth authClient;
  late FirebaseFirestore cloudStoreClient;
  late MockFirebaseStorage dbClient;
  late AuthRemoteDataSource authRemoteDataSource;
  late DocumentReference<Map<String, dynamic>> documentReference;
  late MockUser mockUser;

  const tUser = UserModel.test();
  late FirebaseAuth firebaseAuth;
  late FirebaseFirestore firebaseDBFireStore;
  late FirebaseStorage firebaseFileStorage;
  late UserCredential userCredential;
  // late User user;

  setUpAll(() async {
    firebaseAuth = MockFirebaseAuth();
    firebaseDBFireStore = MockFirebaseDBFireStore();
    firebaseFileStorage = MockFirebaseFileStorage();
    mockUser = MockUser();

    authClient = MockFirebaseAuth();
    cloudStoreClient = FakeFirebaseFirestore();
    documentReference = cloudStoreClient.collection('users').doc();
    await documentReference.set(
      tUser.copyWith(uid: documentReference.id).toJson(),
    );
    dbClient = MockFirebaseStorage();
    mockUser = MockUser()..uid = documentReference.id;
    userCredential = MockUserCredential(mockUser);
    authRemoteDataSource = AuthRemoteDataSourceImpl(
      firebaseAuth: firebaseAuth,
      firebaseFireStore: firebaseDBFireStore,
      firebaseStorage: firebaseFileStorage,
    );

    when(() => authClient.currentUser).thenReturn(mockUser);
  });

  const tPassword = 'Test password';
  const tFullName = 'Test full name';
  const tEmail = 'Test email';

  final tFirebaseAuthException = FirebaseAuthException(
    code: 'user-not-found',
    message: 'There is no user record corresponding to this identifier. '
        'The user may have been deleted',
  );
  group('forgotPassword', () {
    test(
      'should complete successfully when no [Exception] is thrown',
      () async {
        when(
          () => authClient.sendPasswordResetEmail(
            email: any(named: 'email'),
          ),
        ).thenAnswer((_) async => Future.value());

        final call = authRemoteDataSource.forgetPassword(email: tEmail);

        expect(call, completes);

        verify(() => authClient.sendPasswordResetEmail(email: tEmail))
            .called(1);
        verifyNoMoreInteractions(authClient);
      },
    );

    test(
      'should throw [ServerException] when [FirebaseAuthException] is thrown',
      () async {
        when(
          () => authClient.sendPasswordResetEmail(
            email: any(named: 'email'),
          ),
        ).thenThrow(tFirebaseAuthException);

        final call = authRemoteDataSource.forgetPassword;

        expect(() => call(email: tEmail), throwsA(isA<ServerException>()));

        verify(() => authClient.sendPasswordResetEmail(email: tEmail))
            .called(1);
        verifyNoMoreInteractions(authClient);
      },
    );
  });

  group('signIn', () {
    test(
      'should return [LocalUserModel] when no [Exception] is thrown',
      () async {
        when(
          () => authClient.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => userCredential);

        final result = await authRemoteDataSource.signIn(
          email: tEmail,
          password: tPassword,
        );
        expect(result.uid, userCredential.user!.uid);
        expect(result.points, 0);
        verify(
          () => authClient.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(authClient);
      },
    );

    test(
      'should throw [ServerException] when user is null after signing in',
      () async {
        final emptyUserCredential = MockUserCredential();
        when(
          () => authClient.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => emptyUserCredential);

        final call = authRemoteDataSource.signIn;

        expect(
          () => call(email: tEmail, password: tPassword),
          throwsA(isA<ServerException>()),
        );
        verify(
          () => authClient.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(authClient);
      },
    );

    test(
      'should throw [ServerException] when [FirebaseAuthException] is '
      'thrown',
      () async {
        when(
          () => authClient.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(tFirebaseAuthException);

        final call = authRemoteDataSource.signIn;

        expect(
          () => call(email: tEmail, password: tPassword),
          throwsA(isA<ServerException>()),
        );
        verify(
          () => authClient.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(authClient);
      },
    );
  });

  group('signUp', () {
    test(
      'should complete successfully when no [Exception] is thrown',
      () async {
        when(
          () => authClient.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => userCredential);

        when(() => userCredential.user?.updateDisplayName(any())).thenAnswer(
          (_) async => Future.value(),
        );

        when(() => userCredential.user?.updatePhotoURL(any())).thenAnswer(
          (_) async => Future.value(),
        );

        final call = authRemoteDataSource.signUp(
          email: tEmail,
          fullName: tFullName,
          password: tPassword,
        );

        expect(call, completes);

        verify(
          () => authClient.createUserWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);

        await untilCalled(() => userCredential.user?.updateDisplayName(any()));
        await untilCalled(() => userCredential.user?.updatePhotoURL(any()));

        verify(() => userCredential.user?.updateDisplayName(tFullName))
            .called(1);
        verify(() => userCredential.user?.updatePhotoURL(kUsersProfileAvatar))
            .called(1);

        verifyNoMoreInteractions(authClient);
      },
    );
    test(
      'should throw [ServerException] when [FirebaseAuthException] is thrown',
      () async {
        when(
          () => authClient.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(tFirebaseAuthException);

        final call = authRemoteDataSource.signUp;

        expect(
          () => call(
            email: tEmail,
            password: tPassword,
            fullName: tFullName,
          ),
          throwsA(isA<ServerException>()),
        );

        verify(
          () => authClient.createUserWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
      },
    );
  });

  group('updateUser', () {
    setUp(() {
      registerFallbackValue(MockAuthCredential());
    });
    test(
      'should update user displayName successfully when no [Exception] is '
      'thrown',
      () async {
        when(() => mockUser.updateDisplayName(any())).thenAnswer(
          (_) async => Future.value(),
        );

        await authRemoteDataSource.updateUserData(
          action: UpdateUserActionEnum.displayName,
          userData: tFullName,
        );

        verify(() => mockUser.updateDisplayName(tFullName)).called(1);

        verifyNever(() => mockUser.updatePhotoURL(any()));
        verifyNever(() => mockUser.updateEmail(any()));
        verifyNever(() => mockUser.updatePassword(any()));

        final userData =
            await cloudStoreClient.collection('users').doc(mockUser.uid).get();

        expect(userData.data()!['fullName'], tFullName);
      },
    );

    test(
      'should update user email successfully when no [Exception] '
      'is thrown',
      () async {
        when(() => mockUser.updateEmail(any()))
            .thenAnswer((_) async => Future.value());

        await authRemoteDataSource.updateUserData(
          action: UpdateUserActionEnum.email,
          userData: tEmail,
        );

        verify(() => mockUser.updateEmail(tEmail)).called(1);

        verifyNever(() => mockUser.updateDisplayName(any()));
        verifyNever(() => mockUser.updatePhotoURL(any()));
        verifyNever(() => mockUser.updatePassword(any()));

        final user =
            await cloudStoreClient.collection('users').doc(mockUser.uid).get();

        expect(user.data()!['email'], tEmail);
      },
    );

    test(
      'should update user bio successfully when no [Exception] '
      'is thrown',
      () async {
        const newBio = 'new bio';

        await authRemoteDataSource.updateUserData(
          action: UpdateUserActionEnum.bio,
          userData: newBio,
        );
        final user = await cloudStoreClient
            .collection('users')
            .doc(
              documentReference.id,
            )
            .get();

        expect(user.data()!['bio'], newBio);

        verifyNever(() => mockUser.updateDisplayName(any()));
        verifyNever(() => mockUser.updatePhotoURL(any()));
        verifyNever(() => mockUser.updateEmail(any()));
        verifyNever(() => mockUser.updatePassword(any()));
      },
    );

    test(
      'should update user password successfully when no [Exception] is '
      'thrown',
      () async {
        when(() => mockUser.updatePassword(any())).thenAnswer(
          (_) async => Future.value(),
        );

        when(() => mockUser.reauthenticateWithCredential(any()))
            .thenAnswer((_) async => userCredential);

        when(() => mockUser.email).thenReturn(tEmail);

        await authRemoteDataSource.updateUserData(
          action: UpdateUserActionEnum.password,
          userData: jsonEncode({
            'oldPassword': 'oldPassword',
            'newPassword': tPassword,
          }),
        );

        verify(() => mockUser.updatePassword(tPassword));

        verifyNever(() => mockUser.updateDisplayName(any()));
        verifyNever(() => mockUser.updatePhotoURL(any()));
        verifyNever(() => mockUser.updateEmail(any()));

        final user = await cloudStoreClient
            .collection('users')
            .doc(
              documentReference.id,
            )
            .get();

        expect(user.data()!['password'], null);
      },
    );

    test(
      'should update user profilePic successfully when no [Exception] is '
      'thrown',
      () async {
        final newProfilePic = File('assets/images/onBoarding_background.png');

        when(() => mockUser.updatePhotoURL(any())).thenAnswer(
          (_) async => Future.value(),
        );

        await authRemoteDataSource.updateUserData(
          action: UpdateUserActionEnum.photoURL,
          userData: newProfilePic,
        );

        verify(() => mockUser.updatePhotoURL(any())).called(1);

        verifyNever(() => mockUser.updateDisplayName(any()));
        verifyNever(() => mockUser.updatePassword(any()));
        verifyNever(() => mockUser.updateEmail(any()));

        expect(dbClient.storedFilesMap.isNotEmpty, isTrue);
      },
    );
  });
}

// void main() {
//   late FirebaseAuth firebaseAuth;
//   late FirebaseFirestore firebaseDBFireStore;
//   late FirebaseStorage firebaseFileStorage;
//   late UserCredential userCredential;
//   late User user;
//
//   late AuthRemoteDataSource authRemoteDataSource;
//
//   setUp(() {
//     firebaseAuth = MockFirebaseAuth();
//     firebaseDBFireStore = MockFirebaseDBFireStore();
//     firebaseFileStorage = MockFirebaseFileStorage();
//     user = MockUser();
//
//     userCredential = MockUserCredential(user);
//
//     authRemoteDataSource = AuthDataSourceImpl(
//       firebaseAuth: firebaseAuth,
//       firebaseFireStore: firebaseDBFireStore,
//       firebaseStorage: firebaseFileStorage,
//     );
//   });
//   //The Green Phase 🟢----------------------
//   group('SignIn', () {
//     test(
//       'should call [firebaseAuth.signInWithEmailAndPassword()]'
//       ' and should return the right data successfully 🟢',
//       () async {
//         //Arrange
//         when(
//           () => firebaseAuth.signInWithEmailAndPassword(
//             email: any(named: 'email'),
//             password: any(named: 'password'),
//           ),
//         ).thenAnswer((invocation) async => userCredential);
//
//         when(
//           () => firebaseAuth.createUserWithEmailAndPassword(
//               email: 'email', password: 'password'),
//         );
//         //Act
//         final result = await authRemoteDataSource.sigIn(
//           email: 'email',
//           password: 'password',
//         );
//         //Assert
//         expect('email', equals('email'));
//       },
//     );
//   });
// }
