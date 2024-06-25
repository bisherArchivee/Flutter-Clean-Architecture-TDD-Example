import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/failure.dart';
import 'package:education_app/core/app/usecases/usecase.dart';
import 'package:education_app/core/common/feature/localizationFromDB/domain/entity/localization_entity.dart';
import 'package:education_app/core/common/feature/localizationFromDB/domain/repository/localization_repository.dart';

class GetLocalizationUseCase
    extends UseCaseHasParams<Either<Failure, String>, LocalizationEntity> {
  GetLocalizationUseCase({required this.localizationRepository});

  final LocalizationRepository localizationRepository;

  @override
  Future<Either<Failure, String>> call({
    required LocalizationEntity params,
  }) {
    return localizationRepository.getLocal(
      appLanguage: params.languageCode!,
      local: params.textCode!,
    );
  }
}

// /*we added those params to make it easier for testing*/
// class LocalizationParams extends Equatable {
//   const LocalizationParams({required this.appLanguage, required this.local});
//
//   const LocalizationParams.test()
//       : this(appLanguage: '_appLanguage', local: '_local');
//
//   final String appLanguage;
//   final String local;
//
//   @override
//   List<Object?> get props => [appLanguage, local];
// }
