import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/app/errors/exception.dart';
import 'package:education_app/core/common/constant/constants.dart';
import 'package:education_app/core/common/enum/update_user_enum.dart';
import 'package:education_app/feature/authentication/data/model/auth_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthRemoteDataSource {
  Future<void> forgetPassword({required String email});

  Future<UserModel> signIn({required String email, required String password});

  Future<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  Future<void> updateUserData({
    required UpdateUserActionEnum action,
    required dynamic userData,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFireStore,
    required FirebaseStorage firebaseStorage,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseDBFireStore = firebaseFireStore,
        _firebaseFileStorage = firebaseStorage;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseDBFireStore;
  final FirebaseStorage _firebaseFileStorage;

  @override
  Future<void> forgetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Occurred',
        statusCode: kFireBaseStatusCode,
      );
    } on ServerException catch (e) {
      debugPrint(e.message);
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: kFireBaseStatusCode,
      );
    }
  }

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final loginResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = loginResult.user;
      if (user == null) {
        throw const ServerException(
          message: 'User = Null Firebase result',
          statusCode: kFireBaseStatusCode,
        );
      }

      final userData = await _getFirebaseFireStoreData(user.uid);
      if (userData.exists) {
        return UserModel.fromJson(userData.data()!);
      }

      final userModel = await _setFirebaseFireStoreData(user, email);
      return userModel;
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Occurred',
        statusCode: kFireBaseStatusCode,
      );
    } on ServerException catch (e) {
      debugPrint(e.message);
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: kFireBaseStatusCode,
      );
    }
  }

  @override
  Future<void> signUp({
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      final userCred = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCred.user?.updateDisplayName(fullName);
      await userCred.user?.updatePhotoURL(kDefaultUserProfile);
      await _setFirebaseFireStoreData(_firebaseAuth.currentUser!, email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Occurred',
        statusCode: kFireBaseStatusCode,
      );
    } on ServerException catch (e) {
      debugPrint(e.message);
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: kFireBaseStatusCode,
      );
    }
  }

  @override
  Future<void> updateUserData({
    required UpdateUserActionEnum action,
    required dynamic userData,
  }) async {
    try {
      switch (action) {
        case UpdateUserActionEnum.displayName:
          await _firebaseAuth.currentUser
              ?.updateDisplayName(userData as String);
          await _updateFirebaseFireStoreData(
            {UpdateUserActionEnum.displayName.info.clnName: userData},
          );
        case UpdateUserActionEnum.email:
          await _firebaseAuth.currentUser?.updateEmail(userData as String);
          await _updateFirebaseFireStoreData(
            {UpdateUserActionEnum.email.info.clnName: userData},
          );
        case UpdateUserActionEnum.password:
          if (_firebaseAuth.currentUser?.email == null) {
            throw const ServerException(
              message: '‼️ User Does Not Exist',
              statusCode: kFireBaseStatusCode,
            );
          }

          final newPassword =
              jsonDecode(userData as String) as Map<String, dynamic>;
          /*we have to reAuthenticate because
          the user already knows his password*/
          await _firebaseAuth.currentUser?.reauthenticateWithCredential(
            EmailAuthProvider.credential(
              email: _firebaseAuth.currentUser!.email!,
              password: newPassword['oldPassword'] as String,
            ),
          );
          await _firebaseAuth.currentUser
              ?.updatePassword(newPassword['newPassword'] as String);

        case UpdateUserActionEnum.bio:
          await _updateFirebaseFireStoreData(
            {UpdateUserActionEnum.bio.info.clnName: userData},
          );
        case UpdateUserActionEnum.photoURL:
          final ref = _firebaseFileStorage.ref().child(
                '$kUsersProfileAvatar/${_firebaseAuth.currentUser?.uid}',
              );
          final profilePicUrl = ref.getDownloadURL();
          await _firebaseAuth.currentUser
              ?.updatePhotoURL(profilePicUrl as String);
          await _updateFirebaseFireStoreData(
            {UpdateUserActionEnum.photoURL.info.clnName: profilePicUrl},
          );
      }
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Occurred',
        statusCode: kFireBaseStatusCode,
      );
    } on ServerException catch (e) {
      debugPrint(e.message);
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: kFireBaseStatusCode,
      );
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _getFirebaseFireStoreData(
    String uid,
  ) async {
    return _firebaseDBFireStore.collection(kUsersTable).doc(uid).get();
  }

  Future<UserModel> _setFirebaseFireStoreData(
    User user,
    String fallBackEmail,
  ) async {
    final userModel = UserModel(
      uid: user.uid,
      email: user.email ?? fallBackEmail,
      points: 0,
      displayName: user.displayName ?? '',
    );

    await _firebaseDBFireStore
        .collection(kUsersTable)
        .doc(user.uid)
        .set(userModel.toJson());

    return userModel;
  }

  Future<void> _updateFirebaseFireStoreData(Map<String, dynamic> data) async {
    await _firebaseDBFireStore
        .collection(kUsersTable)
        .doc(
          _firebaseAuth.currentUser?.uid,
        )
        .update(data);
  }
}
