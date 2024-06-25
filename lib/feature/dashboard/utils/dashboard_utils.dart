import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/app/di/injection_container.dart';
import 'package:education_app/core/common/constant/constants.dart';
import 'package:education_app/feature/authentication/mapper/auth_user_mapper.dart';
import 'package:education_app/feature/authentication/data/model/auth_user_model.dart';
import 'package:education_app/feature/authentication/domain/entity/auth_user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardUtils {
  const DashboardUtils._();

  static Stream<UserEntity> get userDataStream => sl<FirebaseFirestore>()
      .collection(kUsersTable)
      .doc(sl<FirebaseAuth>().currentUser?.uid)
      .snapshots()
      .map(
        (event) => AuthUserMapperImpl()
            .getUserEntityFromModel(UserModel.fromJson(event.data()!)),
      );

// .map((event) => UserModel.fromJson(event.data()!));
}
