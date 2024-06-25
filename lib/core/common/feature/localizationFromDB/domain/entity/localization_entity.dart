import 'package:equatable/equatable.dart';

class LocalizationEntity extends Equatable {
  const LocalizationEntity({
    this.autoGeneratedId,
    this.id,
    this.screenName,
    this.viewType,
    this.textCode,
    this.text,
    this.languageCode,
  });

  const LocalizationEntity.test()
      : this(
          autoGeneratedId: -1,
          id: '_id',
          screenName: '_screenName',
          viewType: '_viewType',
          textCode: '_textCode',
          text: '_text',
          languageCode: '_languageCode',
        );

  final int? autoGeneratedId;
  final String? id;
  final String? screenName;
  final String? viewType;
  final String? textCode;
  final String? text;
  final String? languageCode;

  @override
  List<Object?> get props =>
      [autoGeneratedId, id, screenName, viewType, textCode, text, languageCode];

  @override
  String toString() {
    return 'LocalizationEntity{autoGeneratedId: $autoGeneratedId,id: $id, '
        'screenName:$screenName, viewType: $viewType, '
        'textCode: $textCode, text: '
        '$text, languageCode: $languageCode}';
  }

  LocalizationEntity copyWith({
    int? autoGeneratedId,
    String? id,
    String? screenName,
    String? viewType,
    String? textCode,
    String? text,
    String? languageCode,
  }) {
    return LocalizationEntity(
      autoGeneratedId: autoGeneratedId ?? this.autoGeneratedId,
      id: id ?? this.id,
      screenName: screenName ?? this.screenName,
      viewType: viewType ?? this.viewType,
      textCode: textCode ?? this.textCode,
      text: text ?? this.text,
      languageCode: languageCode ?? this.languageCode,
    );
  }
}
