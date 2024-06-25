import 'package:education_app/core/common/feature/localizationFromDB/data/model/localization_model.dart';
import 'package:education_app/core/common/feature/localizationFromDB/domain/entity/localization_entity.dart';
import 'package:smartstruct/smartstruct.dart';

part 'localization_mapper.mapper.g.dart';

@Mapper()
abstract class LocalizationMapper {
  ///Create Mapper For (model & entity)
  /*just ignore equatable properties because it will effect .g.dart file
  with errors when mapping entity to model amd vice versa*/
  @Mapping(target: 'props', ignore: true)
  @Mapping(target: 'stringify', ignore: true)
  @Mapping(target: 'hashCode', ignore: true)
  @Mapping(target: 'copyWith', ignore: true)
  LocalizationEntity getLocalizationEntityFromModel(LocalizationModel model);

  /*just ignore equatable properties because it will effect .g.dart file
  with errors when mapping entity to model amd vice versa*/
  @Mapping(target: 'props', ignore: true)
  @Mapping(target: 'stringify', ignore: true)
  @Mapping(target: 'hashCode', ignore: true)
  @Mapping(target: 'copyWith', ignore: true)
  LocalizationModel getLocalizationModelFromEntity(LocalizationEntity entity);
}
