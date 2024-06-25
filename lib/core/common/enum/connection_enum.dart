enum ConnectionStatusEnum {
  loading,
  wifi,
  mobile,
  ethernet,
  vpn,
  bluetooth,
  other,
  none,
}

class Connectiontatus {
  Connectiontatus(this.loginStatusType);

  // UpdateUserLoginStatus(this.key, this.value);

  final String loginStatusType;
// final String value;
}

extension Extension on ConnectionStatusEnum {
  Connectiontatus get info {
    switch (this) {
      case ConnectionStatusEnum.loading:
        return Connectiontatus('loading');
      case ConnectionStatusEnum.wifi:
        return Connectiontatus('wifi');
      case ConnectionStatusEnum.mobile:
        return Connectiontatus('mobile');
      case ConnectionStatusEnum.ethernet:
        return Connectiontatus('ethernet');
      case ConnectionStatusEnum.vpn:
        return Connectiontatus('vpn');
      case ConnectionStatusEnum.bluetooth:
        return Connectiontatus('bluetooth');
      case ConnectionStatusEnum.other:
        return Connectiontatus('other');
      case ConnectionStatusEnum.none:
        return Connectiontatus('none');
    }
  }
}
