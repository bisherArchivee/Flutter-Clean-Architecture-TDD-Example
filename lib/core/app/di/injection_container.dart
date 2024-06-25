import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:education_app/core/common/feature/internetConnection/presentaion/cubit/internet_cubit.dart';
import 'package:education_app/core/common/feature/sharedPreferences/data/datasource/local/sharedPreferences_local_datasource.dart';
import 'package:education_app/core/common/feature/sharedPreferences/data/repository/sharedPreferences_repository_impl.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/repository/sharedPreferences_repository.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/get_bool_usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/get_string_list_usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/get_string_usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/set_bool_usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/set_string_list_usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/domain/usecase/set_string_usecase.dart';
import 'package:education_app/core/common/feature/sharedPreferences/presentation/cubit/sharedPreferences_cubit.dart';
import 'package:education_app/core/common/provider/settings_provider.dart';
import 'package:education_app/core/common/provider/user_provider.dart';
import 'package:education_app/feature/authentication/data/datasource/local/auth_local_data_source.dart';
import 'package:education_app/feature/authentication/data/datasource/remote/auth_remote_data_source.dart';
import 'package:education_app/feature/authentication/data/repository/auth_repository_impl.dart';
import 'package:education_app/feature/authentication/domain/repository/auth_repository.dart';
import 'package:education_app/feature/authentication/domain/usecase/cache_login_type_usecase.dart';
import 'package:education_app/feature/authentication/domain/usecase/forgot_password_usecase.dart';
import 'package:education_app/feature/authentication/domain/usecase/sigin_in_usecase.dart';
import 'package:education_app/feature/authentication/domain/usecase/sigin_up_usecase.dart';
import 'package:education_app/feature/authentication/domain/usecase/update_user_data_usecase.dart';
import 'package:education_app/feature/authentication/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  /*Providers*/
  await _providers();
  // /*Localization Feature*/
  // await _localizationDependencies();
  /*SharedPreferences Feature*/
  await _sharedPreferencesDependencies();
  /*InternetConnection Bloc*/
  await _internetConnection();
  // /*OnBoarding Feature*/
  // await _onBoardingDependencies();
  /*Auth Feature*/
  await _onAuthDependencies();
}

Future<void> _providers() async {
  sl
    ..registerFactory<UserProvider>(UserProvider.new)
    ..registerFactory<SettingsProvider>(SettingsProvider.new);
    // ..registerFactory<InternetConnectionProvider>(
    //   InternetConnectionProvider.new,
    // );
}

///Localization Dependencies
// Future<void> _localizationDependencies() async {
//   // final sharedPreferences = await SharedPreferences.getInstance();
//   /*DataBase*/
//   final database = await $FloorAppDatabase.databaseBuilder(appDBName).build();
//   sl
//     ..registerSingleton<AppDatabase>(database)
//
//     /*DataSource*/
//     ..registerLazySingleton<LocalizationLocalDataSource>(
//       () => LocalizationLocalDataSourceImpl(sl()),
//     )
//
//     /*Repositories*/
//     ..registerLazySingleton<LocalizationRepository>(
//       () => LocalizationRepositoryImpl(localizationLocalDataSource: sl()),
//     )
//
//     /*UseCases*/
//     ..registerLazySingleton<GetLocalizationUseCase>(
//       () => GetLocalizationUseCase(localizationRepository: sl()),
//     )
//
//     /*Blocs*/
//     ..registerFactory<LocalizationCubit>(
//       () => LocalizationCubit(
//         sl(),
//       ),
//     );
// }

///SharedPreferences Dependencies
Future<void> _sharedPreferencesDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  /*Dependencies*/
  sl
    ..registerLazySingleton(() => sharedPreferences)

    /*DataSource*/
    ..registerLazySingleton<SharedPreferencesLocalDataSource>(
      () => SharedPreferencesLocalDataSourceImpl(sharedPreferences: sl()),
    )

    /*Repositories*/
    ..registerLazySingleton<SharedPreferencesRepository>(
      () => SharedPreferencesRepositoryImpl(splashLocalDataSource: sl()),
    )

    /*UseCases*/

    ///GetStringUseCase
    ..registerLazySingleton<GetBoolUseCase>(
      () => GetBoolUseCase(sharedPreferencesRepository: sl()),
    )

    ///GetStringListUseCase
    ..registerLazySingleton<GetStringListUseCase>(
      () => GetStringListUseCase(sharedPreferencesRepository: sl()),
    )

    ///GetStringUseCase
    ..registerLazySingleton<GetStringUseCase>(
      () => GetStringUseCase(sharedPreferencesRepository: sl()),
    )

    ///SetBoolUseCase
    ..registerLazySingleton<SetBoolUseCase>(
      () => SetBoolUseCase(sharedPreferencesRepository: sl()),
    )

    ///SetStringListUseCase
    ..registerLazySingleton<SetStringListUseCase>(
      () => SetStringListUseCase(sharedPreferencesRepository: sl()),
    )

    ///SetBoolUseCase
    ..registerLazySingleton<SetStringUseCase>(
      () => SetStringUseCase(sharedPreferencesRepository: sl()),
    )
    /*Blocs*/
    ..registerFactory<SharedPreferencesCubitImpl>(
      () => SharedPreferencesCubitImpl(
        getBoolUseCase: sl(),
        getStringListUseCase: sl(),
        getStringUseCase: sl(),
        setBoolUseCase: sl(),
        setStringListUseCase: sl(),
        setStringUseCase: sl(),
      ),
    );
}

///InternetConnection Dependencies
Future<void> _internetConnection() async {
  final connectivity = Connectivity();
  sl
    ..registerLazySingleton(() => connectivity)
    /*Blocs*/
    ..registerFactory<InternetCubit>(
      () => InternetCubit(
        connectivity: sl(),
      ),
    );
}

///onAuth Dependencies
Future<void> _onAuthDependencies() async {
  sl
    /*Dependencies*/
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance)

    /*DataSources*/
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        firebaseAuth: sl(),
        firebaseFireStore: sl(),
        firebaseStorage: sl(),
      ),
    )
    ..registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(
        sharedPreferences: sl(),
      ),
    )
    /*Repositories*/
    ..registerLazySingleton<AuthRepository>(
      () => AuthenticationRepositoryImpl(
        authRemoteDataSource: sl(),
        authLocalDataSource: sl(),
      ),
    )
    /*UseCases*/
    ..registerLazySingleton<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(authRepository: sl()),
    )

    ///SignInUseCase
    ..registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(authRepository: sl()),
    )

    ///SignUpUseCase
    ..registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(authRepository: sl()),
    )

    ///UpdateUserDataUseCase
    ..registerLazySingleton<UpdateUserDataUseCase>(
      () => UpdateUserDataUseCase(authRepository: sl()),
    )

    ///CacheLogInTypeUseCase
    ..registerLazySingleton<CacheLogInTypeUseCase>(
      () => CacheLogInTypeUseCase(authRepository: sl()),
    )

    /*Blocs*/
    ..registerFactory<AuthBloc>(
      () => AuthBloc(
        forgotPasswordUseCase: sl(),
        signInUseCase: sl(),
        signUpUseCase: sl(),
        updateUserDataUseCase: sl(),
        cacheLogInTypeUseCase: sl(),
      ),
    );
}


