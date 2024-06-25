import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/failure.dart';
import 'package:education_app/core/app/usecases/usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/repository/sharedPreferences_repository.dart';

class SetStringListUseCase
    extends UseCaseHasParams<Either<Failure, void>, Map<String, List<String>>> {
  SetStringListUseCase({
    required SharedPreferencesRepository sharedPreferencesRepository,
  }) : _sharedPreferencesRepository = sharedPreferencesRepository;

  final SharedPreferencesRepository _sharedPreferencesRepository;

  @override
  Future<Either<Failure, void>> call({
    required Map<String, List<String>> params,
  }) {
    return _sharedPreferencesRepository.setStringList(
      key: params.keys.first,
      value: params.values.first,
    );
  }
}
