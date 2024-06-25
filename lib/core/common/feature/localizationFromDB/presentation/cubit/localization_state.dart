part of 'localization_cubit.dart';

abstract class LocalizationState extends Equatable {
  // const LocalizationState();
  const LocalizationState(
      {required this.local,
      required this.textCode,
      required this.errorMessage});

  final String local;
  final Map<String,String> textCode;
  final String errorMessage;

  @override
  List<Object> get props => [local, textCode, errorMessage];
}

/*🔵Default status */
class LocalizationInitial extends LocalizationState {
   LocalizationInitial()
      : super(local: '', textCode: {}, errorMessage: '');

  @override
  List<Object> get props => [];
}

/*🟡Loading state after GetLocalLoadingState triggered  loading data*/
class GetLocalLoadingState extends LocalizationState {
  const GetLocalLoadingState({required super.textCode})
      : super(local: '', errorMessage: '');

  @override
  List<Object> get props => [textCode];
}

/*🟢Success state after CheckFirstTimeLogin  returns the results*/
class GetLocalSuccessState extends LocalizationState {
  const GetLocalSuccessState({
    required super.textCode,
  }) : super(local:'',errorMessage: '');

  @override
  List<Object> get props => [ textCode];
}

// /*🟢Success state after CheckFirstTimeLogin  returns the results*/
// class GetLocalSuccessState extends LocalizationState {
//   const GetLocalSuccessState({
//     required super.local,
//     required super.textCode,
//   }) : super(errorMessage: '');
//
//   @override
//   List<Object> get props => [local, textCode];
// }

/*🔴Error if there is any error happened while loading data at any state*/
class GetLocalErrorState extends LocalizationState {
  const GetLocalErrorState({
    required super.errorMessage,
    required super.textCode,
  }) : super(local: '');

  @override
  List<Object> get props => [errorMessage, textCode];
}

// /*🔴Error if there is any error happened while loading data at any state*/
// class GetLocalErrorState extends LocalizationState {
//   const GetLocalErrorState({required this.errorMessage})
//       : super(local: '', errorMessage: errorMessage);
//
//   @override
//   List<Object> get props => [errorMessage];
// }
