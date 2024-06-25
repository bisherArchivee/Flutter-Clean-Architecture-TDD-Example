import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/failure.dart';
import 'package:education_app/core/app/usecases/usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/repository/sharedPreferences_repository.dart';

class GetStringListUseCase extends UseCaseHasParams<
    Either<Failure, Map<String, List<String>>>, String> {
  GetStringListUseCase({
    required SharedPreferencesRepository sharedPreferencesRepository,
  }) : _sharedPreferencesRepository = sharedPreferencesRepository;

  final SharedPreferencesRepository _sharedPreferencesRepository;

  @override
  Future<Either<Failure, Map<String, List<String>>>> call({
    required String params,
  }) {
    return _sharedPreferencesRepository.getStringList(params);
  }
}
