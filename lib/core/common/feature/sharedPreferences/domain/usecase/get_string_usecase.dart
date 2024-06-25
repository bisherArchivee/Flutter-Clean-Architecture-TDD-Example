import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/failure.dart';
import 'package:education_app/core/app/usecases/usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/repository/sharedPreferences_repository.dart';

class GetStringUseCase
    extends UseCaseHasParams<Either<Failure, Map<String, String>>, String> {
  GetStringUseCase({
    required SharedPreferencesRepository sharedPreferencesRepository,
  }) : _sharedPreferencesRepository = sharedPreferencesRepository;

  final SharedPreferencesRepository _sharedPreferencesRepository;

  @override
  Future<Either<Failure, Map<String, String>>> call({required String params}) {
    return _sharedPreferencesRepository.getString(params);
  }
}
