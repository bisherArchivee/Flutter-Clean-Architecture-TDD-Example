import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/exception.dart';
import 'package:education_app/core/app/errors/failure.dart';
import 'package:education_app/core/common/feature/localizationFromDB/data/datasource/local/localization_local_datasource.dart';
import 'package:education_app/core/common/feature/localizationFromDB/domain/repository/localization_repository.dart';

class LocalizationRepositoryImpl implements LocalizationRepository {
  LocalizationRepositoryImpl({required this.localizationLocalDataSource});

  final LocalizationLocalDataSource localizationLocalDataSource;

  @override
  Future<Either<Failure, String>> getLocal({
    required String appLanguage,
    required String local,
  }) async {
    try {
      final result = await localizationLocalDataSource.getLocal(
        appLanguage: appLanguage,
        local: local,
      );

      return result != null
          ? Right(result)
          : const Left(
              CacheFailure(
                message: 'Not Found', // Provide a meaningful message here
              ),
            );
      // return Right(result!);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(
        CacheFailure(message: e.toString()),
      );
    }
  }
}
