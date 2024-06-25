import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/failure.dart';
import 'package:education_app/core/app/usecases/usecase.dart';
import 'package:education_app/feature/authentication/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

class ForgotPasswordUseCase
    extends UseCaseHasParams<Either<Failure, void>, String> {
  ForgotPasswordUseCase({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, void>> call({required String params}) {
    return authRepository.forgotPassword(email: params);
  }
}

/*we added those params to make it easier for testing*/
class ForgotPasswordParams extends Equatable {
  const ForgotPasswordParams({required this.email});

  const ForgotPasswordParams.test() : this(email: '_email');

  final String email;

  @override
  List<dynamic> get props => [email];
}
