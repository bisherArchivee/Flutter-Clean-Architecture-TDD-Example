import 'package:bloc/bloc.dart';
import 'package:education_app/core/common/feature/localizationFromDB/domain/entity/localization_entity.dart';
import 'package:education_app/core/common/feature/localizationFromDB/domain/usecase/get_localization_usecase.dart';
import 'package:equatable/equatable.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit(this._getLocalizationUseCase)
      : super(LocalizationInitial());

  final GetLocalizationUseCase _getLocalizationUseCase;

  Future<void> getLocals({
    required String appLanguage,
    required Map<String, String> textCodesMap,
  }) async {
    final results = <String, String>{};

    for (final entry in textCodesMap.entries) {
      final key = entry.key;
      // final value = entry.value;

      final localizationEntity = LocalizationEntity(
        languageCode: appLanguage,
        textCode: key,
      );

      final result = await _getLocalizationUseCase(params: localizationEntity);

      result.fold(
        (l) => results[key] = key,
        (r) => results[key] = r,
      );
    }

    emit(GetLocalSuccessState(textCode: results));
  }
}

// class LocalizationCubit extends Cubit<LocalizationState> {
//   LocalizationCubit(this._getLocalizationUseCase)
//       : super(const LocalizationInitial());
//
//   final GetLocalizationUseCase _getLocalizationUseCase;
//
//   Future<void> getLocals({
//     required String appLanguage,
//     required Map<String, String> textCodeMap,
//   }) async {
//     for (var entry in textCodeMap.entries) {
//       final textCode = entry.key;
//       final localizedText = entry.value;
//
//       emit(GetLocalLoadingState(textCode: textCode));
//
//       final localizationEntity = LocalizationEntity(
//         languageCode: appLanguage,
//         textCode: textCode,
//       );
//
//       // If localizedText is provided, skip fetching and directly emit success state
//       if (localizedText != null) {
//         emit(GetLocalSuccessState(local: localizedText, textCode: textCode));
//       } else {
//         final result =
//         await _getLocalizationUseCase(params: localizationEntity);
//
//         result.fold(
//               (l) => emit(
//             GetLocalErrorState(
//               errorMessage: l.message,
//               textCode: textCode,
//             ),
//           ),
//             (r) => emit(GetLocalSuccessState(local: r, textCode: textCode)),
//         );
//       }
//     }
//   }
// }
