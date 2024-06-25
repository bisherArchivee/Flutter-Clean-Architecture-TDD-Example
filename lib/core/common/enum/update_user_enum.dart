enum UpdateUserActionEnum {
  displayName,
  email,
  password,
  bio,
  photoURL,
}

class UpdateUserActionInfo {
  UpdateUserActionInfo(this.clnName);

  final String clnName;
// final String clnValue;
}

extension Extension on UpdateUserActionEnum {
  UpdateUserActionInfo get info {
    switch (this) {
      case UpdateUserActionEnum.displayName:
        return UpdateUserActionInfo('displayName');
      case UpdateUserActionEnum.email:
        return UpdateUserActionInfo('email');
      case UpdateUserActionEnum.password:
        return UpdateUserActionInfo('password');
      case UpdateUserActionEnum.bio:
        return UpdateUserActionInfo('bio');
      case UpdateUserActionEnum.photoURL:
        return UpdateUserActionInfo('photoURL');
    }
  }
}
