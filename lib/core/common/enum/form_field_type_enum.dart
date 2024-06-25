

enum FormFieldTypeEnum {
  normal,
  password,
  confirmPassword,
  phone,
  email,
  number,
  date,
}

class FormFieldTypeInfo {
  FormFieldTypeInfo(this.type);

  // SnackBarTypeInfo(this.key, this.value);

  // final String key;
  final String type;
}

extension Extension on FormFieldTypeEnum {
  FormFieldTypeInfo get info {
    switch (this) {
      case FormFieldTypeEnum.normal:
        return FormFieldTypeInfo('normal');
      case FormFieldTypeEnum.password:
        return FormFieldTypeInfo('password');
      case FormFieldTypeEnum.confirmPassword:
        return FormFieldTypeInfo('confirmPassword');
      case FormFieldTypeEnum.phone:
        return FormFieldTypeInfo('phone');
      case FormFieldTypeEnum.email:
        return FormFieldTypeInfo('email');
      case FormFieldTypeEnum.number:
        return FormFieldTypeInfo('number');
      case FormFieldTypeEnum.date:
        return FormFieldTypeInfo('date');
    }
  }
}
