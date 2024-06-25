part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

/*🔵Default status before any triggered event*/
class AuthInitialState extends AuthState {}

/*🟡Loading state after SignInEvent event triggered and loading data*/
class AuthLoadingState extends AuthState {}

/*🔴Error if there is any error happened while loading data at any state*/
class AuthErrorState extends AuthState {
  const AuthErrorState({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}

/*🟢Success state after CheckLoggedInStatus event returns the results*/
class SignInSuccessState extends AuthState {
  const SignInSuccessState({required this.userEntity});

  final UserEntity userEntity;

  @override
  List<Object> get props => [userEntity];
}

/*🟢Success state after SignUpEvent event returns the results*/
class SignedUpSuccessState extends AuthState {
  const SignedUpSuccessState();
}

/*🟢Success state after ForgetPasswordEvent event returns the results*/
class ForgetPasswordSentSuccessState extends AuthState {
  const ForgetPasswordSentSuccessState();
}

/*🟢Success state after UpdateUserDataEvent event returns the results*/
class UserUpdatedSuccessState extends AuthState {
  const UserUpdatedSuccessState();
}

/*🟢Success state after CacheLogInType state only returns the results*/
class CacheLogInTypeSuccessState extends AuthState {
  const CacheLogInTypeSuccessState();
}
