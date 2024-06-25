import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/failure.dart';
import 'package:education_app/core/app/usecases/usecase.dart';
import 'package:education_app/feature/authentication/domain/entity/auth_user_entity.dart';
import 'package:education_app/feature/authentication/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

class SignInUseCase
    extends UseCaseHasParams<Either<Failure, UserEntity>, SignInParams> {
  SignInUseCase({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, UserEntity>> call({required SignInParams params}) {
    return authRepository.sigIn(email: params.email, password: params.password);
  }

// @override
// Future<Either<Failure, UserEntity>> call(SignInParams params) {
//   return authRepository.sigIn(email: params., password: password)
// }
}

/*we added those params to make it easier for testing*/
class SignInParams extends Equatable {
  const SignInParams({required this.email, required this.password});

  const SignInParams.test() : this(email: '_email', password: '_password');

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
