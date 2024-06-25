import 'package:education_app/feature/authentication/data/model/auth_user_model.dart';
import 'package:education_app/feature/authentication/domain/entity/auth_user_entity.dart';
import 'package:smartstruct/smartstruct.dart';

part 'auth_user_mapper.mapper.g.dart';

@Mapper()
abstract class AuthUserMapper {
  ///Create Mapper For (model & entity)
  /*just ignore equatable properties because it will effect .g.dart file
  with errors when mapping entity to model amd vice versa*/
  @Mapping(target: 'props', ignore: true)
  @Mapping(target: 'stringify', ignore: true)
  @Mapping(target: 'hashCode', ignore: true)
  @Mapping(target: 'copyWith', ignore: true)
  UserEntity getUserEntityFromModel(UserModel model);

  /*just ignore equatable properties because it will effect .g.dart file
  with errors when mapping entity to model amd vice versa*/
  @Mapping(target: 'props', ignore: true)
  @Mapping(target: 'stringify', ignore: true)
  @Mapping(target: 'hashCode', ignore: true)
  @Mapping(target: 'copyWith', ignore: true)
  UserModel getUserModelFromEntity(UserEntity entity);
}
