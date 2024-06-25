import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'localization_model.g.dart';

@JsonSerializable()
@Entity(primaryKeys: ['id'])
class LocalizationModel extends Equatable {

  const LocalizationModel({
    this.autoGeneratedId,
    this.id,
    this.screenName,
    this.viewType,
    this.textCode,
    this.text,
    this.languageCode,
  });

  const LocalizationModel.test()
      : this(
          autoGeneratedId: -1,
          id: '_id',
          screenName: '_screenName',
          viewType: '_viewType',
          textCode: '_textCode',
          text: '_text',
          languageCode: '_languageCode',
        );

  factory LocalizationModel.fromJson(Map<String, dynamic> json) =>
      _$LocalizationModelFromJson(json);
  Map<String, dynamic> toJson() => _$LocalizationModelToJson(this);

  @primaryKey
  final int? autoGeneratedId;
  final String? id;
  final String? screenName;
  final String? viewType;
  final String? textCode;
  final String? text;
  final String? languageCode;
  static const className = 'LocalizationModel';

  @override
  List<Object?> get props =>
      [autoGeneratedId, id, screenName, viewType, textCode, text, languageCode];

  @override
  String toString() {
    return 'LocalizationModel{autoGeneratedId: $autoGeneratedId,id: $id, '
        'screenName:$screenName, viewType: $viewType, '
        'textCode: $textCode, text: '
        '$text, languageCode: $languageCode}';
  }

  LocalizationModel copyWith({
    int? autoGeneratedId,
    String? id,
    String? screenName,
    String? viewType,
    String? textCode,
    String? text,
    String? languageCode,
  }) {
    return LocalizationModel(
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
