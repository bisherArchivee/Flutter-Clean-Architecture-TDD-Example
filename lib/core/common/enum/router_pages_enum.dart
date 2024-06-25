enum RouterPagesEnum {
  splashMobile,
  onboarding,
  signIn,
  signUp,
  forgotPassword,
  dashboard,
  dashboardDetails,
  profile,
  editProfile,
}

class RouterPages {
  RouterPages(this.path, this.name);

  final String path;
  final String name;
}

extension Extension on RouterPagesEnum {
  RouterPages get info {
    switch (this) {
      case RouterPagesEnum.splashMobile:
        return RouterPages('/', 'Splash Page');
      case RouterPagesEnum.onboarding:
        return RouterPages('onBoarding', 'OnBoarding Page');
      case RouterPagesEnum.signIn:
        return RouterPages('signIn', 'Sign In Page');
      case RouterPagesEnum.signUp:
        return RouterPages('signUp', 'Sign Up Page');
      case RouterPagesEnum.forgotPassword:
        /*🔴 Don't change Path Name, it this is firebase screen path*/
        return RouterPages('forgot-password', 'Forgot Password Page');
      case RouterPagesEnum.dashboard:
        return RouterPages('dashboard', 'Dashboard Page');
      case RouterPagesEnum.dashboardDetails:
        return RouterPages('dashboardDetails', 'Dashboard Details Page');
      case RouterPagesEnum.profile:
        return RouterPages('profile', 'Profile Page');
      case RouterPagesEnum.editProfile:
        return RouterPages('editProfile', 'Edit Profile Page');
    }
  }
}
