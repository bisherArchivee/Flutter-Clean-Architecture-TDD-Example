part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SignInEvent extends AuthEvent {
  const SignInEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  const SignUpEvent({
    required this.email,
    required this.password,
    required this.name,
  });

  final String email;
  final String password;
  final String name;

  @override
  List<Object?> get props => [email, password, name];
}

class ForgetPasswordEvent extends AuthEvent {
  const ForgetPasswordEvent({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}

class UpdateUserDataEvent extends AuthEvent {
  const UpdateUserDataEvent({
    required this.updateUserAction,
    required this.userData,
  });

  final UpdateUserActionEnum updateUserAction;
  final dynamic userData;

  @override
  List<Object?> get props => [updateUserAction, userData];
}

class CacheLoginTypeEvent extends AuthEvent {
  const CacheLoginTypeEvent({required this.loginType});

  final String loginType;

  @override
  List<Object?> get props => [loginType];
}
