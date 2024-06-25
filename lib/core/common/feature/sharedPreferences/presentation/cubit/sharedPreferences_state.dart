import 'package:equatable/equatable.dart';

abstract class SharedPreferencesState extends Equatable {
  const SharedPreferencesState();

  @override
  List<Object> get props => [];
}

/*🔵Default status before any triggered event*/
class SharedPreferencesInitialState extends SharedPreferencesState {}

/*🔴Error if there is any error happened while loading data at any state*/
class SharedPreferencesErrorState extends SharedPreferencesState {
  const SharedPreferencesErrorState({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}

/*-------------------------------------------------------------------------*/
/*🟡Loading state after CacheFirstTimeLogIn event triggered and loading data*/
class GetBoolLoadingState extends SharedPreferencesState {
  const GetBoolLoadingState({required this.key});

  final String key;

  @override
  List<Object> get props => [key];
}

/*🟢Success state after CacheFirstTimeLogIn event returns the results*/
class GetBoolSuccessState extends SharedPreferencesState {
  const GetBoolSuccessState({required this.keyValueMap});

  final Map<String, bool> keyValueMap;

  @override
  List<Object> get props => [keyValueMap];
}

/*-------------------------------------------------------------------------*/
/*🟡Loading state after IsFirstTimeLoginLoading triggered and loading data*/
class GetStringListLoadingState extends SharedPreferencesState {
  const GetStringListLoadingState({required this.key});

  final String key;

  @override
  List<Object> get props => [key];
}

/*🟢Success state after IsFirstTimeLoginSuccess triggered and loading data*/
class GetStringListSuccessState extends SharedPreferencesState {
  const GetStringListSuccessState({required this.keyValueMap});

  final Map<String, List<String>> keyValueMap;

  @override
  List<Object> get props => [keyValueMap];
}

/*-------------------------------------------------------------------------*/
/*🟡Loading state after IsDarkTheme Loading triggered and loading data*/
class GetStringLoadingState extends SharedPreferencesState {
  const GetStringLoadingState({required this.key});

  final String key;

  @override
  List<Object> get props => [key];
}

/*🟢Success state after IsDarkTheme Success triggered and loading data*/
class GetStringSuccessState extends SharedPreferencesState {
  const GetStringSuccessState({required this.keyValueMap});

  final Map<String, String> keyValueMap;

  @override
  List<Object> get props => [keyValueMap];
}

/*-------------------------------------------------------------------------*/
/*🟡Loading state after IsDarkTheme Loading triggered and loading data*/
class SetBoolLoadingState extends SharedPreferencesState {
  const SetBoolLoadingState({required this.key});

  final String key;

  @override
  List<Object> get props => [key];
}

/*🟢Success state after IsDarkTheme Success triggered and loading data*/
class SetBoolSuccessState extends SharedPreferencesState {
  const SetBoolSuccessState();
}

/*-------------------------------------------------------------------------*/
/*🟡Loading state after IsDarkTheme Loading triggered and loading data*/
class SetStringListLoadingState extends SharedPreferencesState {
  const SetStringListLoadingState({required this.key});

  final String key;

  @override
  List<Object> get props => [key];
}

/*🟢Success state after IsDarkTheme Success triggered and loading data*/
class SetStringListSuccessState extends SharedPreferencesState {
  const SetStringListSuccessState();
}

/*-------------------------------------------------------------------------*/
/*🟡Loading state after IsDarkTheme Loading triggered and loading data*/
class SetStringLoadingState extends SharedPreferencesState {
  const SetStringLoadingState({required this.key});

  final String key;

  @override
  List<Object> get props => [key];
}

/*🟢Success state after IsDarkTheme Success triggered and loading data*/
class SetStringSuccessState extends SharedPreferencesState {
  const SetStringSuccessState();
}
// GetLoginStatus
// IsDarkTheme
// IsFirstTimeLogin
