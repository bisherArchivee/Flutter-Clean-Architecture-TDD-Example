import 'package:dartz/dartz.dart';
import 'package:education_app/core/app/errors/failure.dart';
import 'package:education_app/core/app/usecases/usecase.dart';
import 'package:education_app/core/common/enum/update_user_enum.dart';
import 'package:education_app/feature/authentication/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateUserDataUseCase
    extends UseCaseHasParams<Either<Failure, void>, UpdateUserParams> {
  UpdateUserDataUseCase({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, void>> call({required UpdateUserParams params}) {
    return authRepository.updateUserData(
      action: params.action,
      userData: params.userData,
    );
  }
}

/*we added those params to make it easier for testing*/
class UpdateUserParams extends Equatable {
  const UpdateUserParams({required this.action, required this.userData});

  const UpdateUserParams.test()
      : this(action: UpdateUserActionEnum.displayName, userData: '');

  final UpdateUserActionEnum action;
  final dynamic userData;

  @override
  List<dynamic> get props => [action, userData];
}
