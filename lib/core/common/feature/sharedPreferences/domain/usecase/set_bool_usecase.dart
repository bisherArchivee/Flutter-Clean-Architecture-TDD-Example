import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/failure.dart';
import 'package:education_app/core/app/usecases/usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/repository/sharedPreferences_repository.dart';

class SetBoolUseCase
    extends UseCaseHasParams<Either<Failure, void>, Map<String, bool>> {
  SetBoolUseCase({
    required SharedPreferencesRepository sharedPreferencesRepository,
  }) : _sharedPreferencesRepository = sharedPreferencesRepository;

  final SharedPreferencesRepository _sharedPreferencesRepository;

  @override
  Future<Either<Failure, void>> call({required Map<String, bool> params}) {
    return _sharedPreferencesRepository.setBool(
      key: params.keys.first,
      value: params.values.first,
    );
  }
}
