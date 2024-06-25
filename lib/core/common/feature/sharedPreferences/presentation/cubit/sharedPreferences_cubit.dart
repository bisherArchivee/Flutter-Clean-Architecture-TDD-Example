import 'package:bloc/bloc.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/get_bool_usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/get_string_list_usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/get_string_usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/set_bool_usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/set_string_list_usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/set_string_usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/presentation/cubit/sharedPreferences_state.dart';

// part 'sharedPreferences_state.dart';

abstract class SharedPreferencesCubit {
  Future<void> getBoolUseCubit(String key);

  Future<void> getStringListCubit(String key);

  Future<void> getStringCubit(String key);

  Future<void> setBoolCubit(Map<String, bool> keyValueMap);

  Future<void> setStringListCubit(Map<String, List<String>> keyValueMap);

  Future<void> setStringCubit(Map<String, String> keyValueMap);
}

class SharedPreferencesCubitImpl extends Cubit<SharedPreferencesState>
    implements SharedPreferencesCubit {
  SharedPreferencesCubitImpl({
    required GetBoolUseCase getBoolUseCase,
    required GetStringListUseCase getStringListUseCase,
    required GetStringUseCase getStringUseCase,
    required SetBoolUseCase setBoolUseCase,
    required SetStringListUseCase setStringListUseCase,
    required SetStringUseCase setStringUseCase,
  })  : _getBoolUseCase = getBoolUseCase,
        _getStringListUseCase = getStringListUseCase,
        _getStringUseCase = getStringUseCase,
        _setBoolUseCase = setBoolUseCase,
        _setStringListUseCase = setStringListUseCase,
        _setStringUseCase = setStringUseCase,
        super(SharedPreferencesInitialState());

  final GetBoolUseCase _getBoolUseCase;
  final GetStringListUseCase _getStringListUseCase;
  final GetStringUseCase _getStringUseCase;
  final SetBoolUseCase _setBoolUseCase;
  final SetStringListUseCase _setStringListUseCase;
  final SetStringUseCase _setStringUseCase;

  @override
  Future<void> getBoolUseCubit(String key) async {
    emit(GetBoolLoadingState(key: key));
    final result = await _getBoolUseCase(params: key);
    result.fold(
      (l) => emit(SharedPreferencesErrorState(errorMessage: l.message)),
      (r) => emit(GetBoolSuccessState(keyValueMap: r)),
    );
  }

  @override
  Future<void> getStringCubit(String key) async {
    emit(GetStringLoadingState(key: key));
    final result = await _getStringUseCase(params: key);
    result.fold(
      (l) => emit(SharedPreferencesErrorState(errorMessage: l.message)),
      (r) => emit(GetStringSuccessState(keyValueMap: r)),
    );
  }

  @override
  Future<void> getStringListCubit(String key) async {
    emit(GetStringListLoadingState(key: key));
    final result = await _getStringListUseCase(params: key);
    result.fold(
      (l) => emit(SharedPreferencesErrorState(errorMessage: l.message)),
      (r) => emit(GetStringListSuccessState(keyValueMap: r)),
    );
  }

  @override
  Future<void> setBoolCubit(Map<String, bool> keyValueMap) async {
    emit(SetBoolLoadingState(key: keyValueMap.keys.first));
    final result = await _setBoolUseCase(params: keyValueMap);
    result.fold(
      (l) => emit(SharedPreferencesErrorState(errorMessage: l.message)),
      (r) => emit(const SetBoolSuccessState()),
    );
  }

  @override
  Future<void> setStringCubit(Map<String, String> keyValueMap) async {
    emit(SetStringLoadingState(key: keyValueMap.keys.first));
    final result = await _setStringUseCase(params: keyValueMap);
    result.fold(
      (l) => emit(SharedPreferencesErrorState(errorMessage: l.message)),
      (r) => emit(const SetStringSuccessState()),
    );
  }

  @override
  Future<void> setStringListCubit(Map<String, List<String>> keyValueMap) async {
    emit(SetStringListLoadingState(key: keyValueMap.keys.first));
    final result = await _setStringListUseCase(params: keyValueMap);
    result.fold(
      (l) => emit(SharedPreferencesErrorState(errorMessage: l.message)),
      (r) => emit(const SetStringListSuccessState()),
    );
  }

// @override
// Future<void> getLoginStatusCubit() async {
//   emit(const GetLoginStatusLoadingState());
//   final result = await _getLoginStatusUseCase();
//   result.fold(
//     (l) => emit(SharedPreferencesErrorState(errorMessage: l.message)),
//     (r) => emit(GetLoginStatusSuccessState(getLoginStatus: r)),
//   );
// }
//
// @override
// Future<void> isDarkThemeCubit() async {
//   emit(const IsDarkThemeLoadingState());
//   final result = await _isDarkThemeUseCase();
//   result.fold(
//     (l) => emit(SharedPreferencesErrorState(errorMessage: l.message)),
//     (r) => emit(IsDarkThemeSuccessState(isDarkTheme: r)),
//   );
// }
//
// @override
// Future<void> isFirstTimeLoginCubit() async {
//   emit(const IsFirstTimeLoginLoadingState());
//   final result = await _isFirstTimeLoginUseCase();
//   result.fold(
//     (l) => emit(SharedPreferencesErrorState(errorMessage: l.message)),
//     (r) => emit(IsFirstTimeLoginSuccessState(isFirstTimeLogin: r)),
//   );
// }
//
// @override
// Future<void> cachingFirstTimeLoginInCubit() async {
//   emit(const CacheFirstTimeLogInLoadingState());
//   final result = await _cacheFirstLogInUseCase();
//   result.fold(
//     (failure) =>
//         emit(SharedPreferencesErrorState(errorMessage: failure.message)),
//     (_) => emit(const CacheFirstTimeLogInSuccessState()),
//   );
// }
}
