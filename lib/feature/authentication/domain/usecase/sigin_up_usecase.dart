import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/failure.dart';
import 'package:education_app/core/app/usecases/usecase.dart';
import 'package:education_app/feature/authentication/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

class SignUpUseCase
    extends UseCaseHasParams<Either<Failure, void>, SignUpParams> {
  SignUpUseCase({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, void>> call({required SignUpParams params}) {
    return authRepository.signup(
      email: params.email,
      fullName: params.fullName,
      password: params.password,
    );
  }
}

/*we added those params to make it easier for testing*/
class SignUpParams extends Equatable {
  const SignUpParams({
    required this.email,
    required this.password,
    required this.fullName,
  });

  const SignUpParams.test()
      : this(email: '_email', password: '_password', fullName: '_fullName');

  final String email;
  final String password;
  final String fullName;

  @override
  List<Object?> get props => [email, password, fullName];
}
