import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:education_app/core/common/enum/update_user_enum.dart';
import 'package:education_app/feature/authentication/domain/entity/auth_user_entity.dart';
import 'package:education_app/feature/authentication/domain/usecase/cache_login_type_usecase.dart';
import 'package:education_app/feature/authentication/domain/usecase/forgot_password_usecase.dart';
import 'package:education_app/feature/authentication/domain/usecase/sigin_in_usecase.dart';
import 'package:education_app/feature/authentication/domain/usecase/sigin_up_usecase.dart';
import 'package:education_app/feature/authentication/domain/usecase/update_user_data_usecase.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignInUseCase signInUseCase,
    required SignUpUseCase signUpUseCase,
    required ForgotPasswordUseCase forgotPasswordUseCase,
    required UpdateUserDataUseCase updateUserDataUseCase,
    required CacheLogInTypeUseCase cacheLogInTypeUseCase,
  })  : _signInUseCase = signInUseCase,
        _signUpUseCase = signUpUseCase,
        _forgotPasswordUseCase = forgotPasswordUseCase,
        _updateUserDataUseCase = updateUserDataUseCase,
        _cacheLogInTypeUseCase = cacheLogInTypeUseCase,
        super(AuthInitialState()) {
    /*we have added this auth event because
     all of the events sharing the state of loading when we call them
     any event got called will trigger AuthEvent because it extended
     it and it will call the super */
    on<AuthEvent>(
      (event, emit) {
        emit(AuthLoadingState()); /*don't forget to ⚠️ emit loading*/
      },
    );
    on<SignInEvent>(_signInUseCaseEventHandler);
    on<SignUpEvent>(_signUpUseCaseUseHandler);
    on<ForgetPasswordEvent>(_forgotPasswordUseCaseHandler);
    on<UpdateUserDataEvent>(_updateUserUseCaseHandler);
    on<CacheLoginTypeEvent>(_cacheLoginTypeHandler);
  }

  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final UpdateUserDataUseCase _updateUserDataUseCase;
  final CacheLogInTypeUseCase _cacheLogInTypeUseCase;

  FutureOr<void> _signInUseCaseEventHandler(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signInUseCase(
      params: SignInParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) => emit(AuthErrorState(errorMessage: failure.message)),
      (user) => emit(SignInSuccessState(userEntity: user)),
    );
  }

  Future<void> _signUpUseCaseUseHandler(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signUpUseCase(
      params: SignUpParams(
        email: event.email,
        fullName: event.name,
        password: event.password,
      ),
    );
    result.fold(
      (failure) => emit(AuthErrorState(errorMessage: failure.message)),
      (_) => emit(const SignedUpSuccessState()),
    );
  }

  Future<void> _forgotPasswordUseCaseHandler(
    ForgetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _forgotPasswordUseCase(params: event.email);
    result.fold(
      (failure) => emit(AuthErrorState(errorMessage: failure.message)),
      (_) => emit(const ForgetPasswordSentSuccessState()),
    );
  }

  Future<void> _updateUserUseCaseHandler(
    UpdateUserDataEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());

    final result = await _updateUserDataUseCase(
      params: UpdateUserParams(
        action: event.updateUserAction,
        userData: event.userData,
      ),
    );
    result.fold(
      (failure) => emit(AuthErrorState(errorMessage: failure.message)),
      (_) => emit(const UserUpdatedSuccessState()),
    );
  }

  Future<void> _cacheLoginTypeHandler(
    CacheLoginTypeEvent event,
    Emitter<AuthState> emit,
  ) async {
    ///always emit the state before doing the call
    emit(AuthLoadingState());

    final result = await _cacheLogInTypeUseCase(params: event.loginType);
    result.fold(
      (failure) => emit(AuthErrorState(errorMessage: failure.message)),
      (_) => emit(const CacheLogInTypeSuccessState()),
    );
  }
}
