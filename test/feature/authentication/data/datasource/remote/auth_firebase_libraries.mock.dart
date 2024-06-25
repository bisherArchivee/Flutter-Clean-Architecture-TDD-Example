import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseDBFireStore extends Mock implements FirebaseFirestore {}

class MockFirebaseFileStorage extends Mock implements FirebaseStorage {}

class MockUserCredential extends Mock implements UserCredential {
  /*we've added user into the constructor to pass it */
  MockUserCredential([User? user]) : _user = user;
  User? _user;

  @override
  User? get user => _user;

  set user(User? value) {
    /*when we add  setter make sure that the new value != the old one*/
    if (_user != value) _user = value;
  }
}

/*we have to mock the user becUSE it's private
and we can't simulate this data we have to mock it*/
class MockUser extends Mock implements User {
  String _uid = 'test_uid';

  /*we override the user in super implementation to write ours*/
  @override
  String get uid => _uid;

  set uid(String value) {
    if (_uid != value) _uid = value;
  }
}

class MockAuthCredential extends Mock implements AuthCredential {}
