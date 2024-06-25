enum LoginStatusEnum {
  signedOut,
  signedInUsingFireBase,
  signedInUsingFaceBook,
  signedInUsingGoogle,
  signedInUsingICloud,
  signedInUsingEmailPassword,
}

class UpdateUserLoginStatus {
  UpdateUserLoginStatus(this.loginStatusType);

  // UpdateUserLoginStatus(this.key, this.value);

  final String loginStatusType;
// final String value;
}

extension Extension on LoginStatusEnum {
  UpdateUserLoginStatus get info {
    switch (this) {
      case LoginStatusEnum.signedOut:
        return UpdateUserLoginStatus('signed_out');
      case LoginStatusEnum.signedInUsingFaceBook:
        return UpdateUserLoginStatus('facebook');
      case LoginStatusEnum.signedInUsingFireBase:
        return UpdateUserLoginStatus('firebase');
      case LoginStatusEnum.signedInUsingGoogle:
        return UpdateUserLoginStatus('google');
      case LoginStatusEnum.signedInUsingICloud:
        return UpdateUserLoginStatus('icloud');
      case LoginStatusEnum.signedInUsingEmailPassword:
        return UpdateUserLoginStatus('email_pass');
    }
  }
}
