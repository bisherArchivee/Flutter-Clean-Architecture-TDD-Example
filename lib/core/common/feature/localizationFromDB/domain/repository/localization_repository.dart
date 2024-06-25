import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/failure.dart';

abstract class LocalizationRepository {
  const LocalizationRepository();

  Future<Either<Failure, String>> getLocal({
    required String appLanguage,
    required String local,
  });
}
