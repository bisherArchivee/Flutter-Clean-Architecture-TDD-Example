import 'package:education_app/core/app/di/injection_container.dart';
import 'package:education_app/core/common/enum/router_pages_enum.dart';
import 'package:education_app/core/common/feature/internetConnection/presentaion/cubit/internet_cubit.dart';
import 'package:education_app/core/common/feature/sharedPreferences/presentation/cubit/sharedPreferences_cubit.dart';
import 'package:education_app/core/common/presentation/page/under_consruction_page.dart';
import 'package:education_app/feature/authentication/presentation/bloc/auth_bloc.dart';
import 'package:education_app/feature/authentication/presentation/page/sign_in_page.dart';
import 'package:education_app/feature/authentication/presentation/page/sign_up_page.dart';
import 'package:education_app/feature/dashboard/presentation/page/dashboard_page.dart';
import 'package:education_app/feature/on_boarding/presentation/page/on_boarding_page.dart';
import 'package:education_app/feature/profile/presentation/page/edit_profile_page.dart';
import 'package:education_app/feature/profile/presentation/page/profile_page.dart';
import 'package:education_app/feature/splash/presentation/page/splash_page.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fui;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// enum AppRoute {
//   onboarding,
//   signIn,
//   signUp,
//   dashboard,
//   account,
// }

final goRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: RouterPagesEnum.splashMobile.info.path,
      name: RouterPagesEnum.splashMobile.info.name,
      builder: (context, state) => _getSplashBlocProvider(),
      //_getOnBoardingBlocProvider(),
      routes: [
        GoRoute(
          path: RouterPagesEnum.onboarding.info.path,
          name: RouterPagesEnum.onboarding.info.name,
          builder: (context, state) => _getOnBoardingBlocProvider(),
        ),
        GoRoute(
          path: RouterPagesEnum.signIn.info.path,
          name: RouterPagesEnum.signIn.info.name,
          builder: (context, state) => _getSigInBlocProvider(),
          // pageBuilder: (context, state) => MaterialPage(
          //     key: state.pageKey,
          //     child:  ProductScreen(productId: state.params["id"]!),
          //     fullscreenDialog: true),
        ),
        GoRoute(
          path: RouterPagesEnum.signUp.info.path,
          name: RouterPagesEnum.signUp.info.name,
          builder: (context, state) => _getSigUpBlocProvider(),
          // pageBuilder: (context, state) =>
          //     MaterialPage(
          //         key: state.pageKey,
          //         child: const ShoppingCartScreen(),
          //         fullscreenDialog: true),
        ),
        GoRoute(
          path: RouterPagesEnum.dashboard.info.path,
          name: RouterPagesEnum.dashboard.info.name,
          builder: (context, state) => _getDashboardBlocProvider(),
          routes: [
            GoRoute(
              path: RouterPagesEnum.profile.info.path,
              name: RouterPagesEnum.profile.info.name,
              builder: (context, state) => _getProfileBlocProvider(),
              routes: [
                GoRoute(
                  path: RouterPagesEnum.editProfile.info.path,
                  name: RouterPagesEnum.editProfile.info.name,
                  builder: (context, state) => _getEditProfileBlocProvider(),
                  // pageBuilder: (context, state) =>
                  //     MaterialPage(
                  //         key: state.pageKey,
                  //         child: const ShoppingCartScreen(),
                  //         fullscreenDialog: true),
                ),
              ],
            ),
          ]
          // pageBuilder: (context, state) =>
          //     MaterialPage(
          //         key: state.pageKey,
          //         child: const OrdersListScreen(),
          //         fullscreenDialog: true),
          ,
        ),
        GoRoute(
          path: RouterPagesEnum.forgotPassword.info.path,
          name: RouterPagesEnum.forgotPassword.info.name,
          builder: (context, state) => const fui.ForgotPasswordScreen(),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const UnderConstructionPage(),
// errorPageBuilder: (context, state) => MaterialPage(
//     key: state.pageKey,
//     child: const NotFoundScreen(),
//     fullscreenDialog: true),
);

/*-------MultiBlocProviders -------------*/
MultiBlocProvider _getDashboardBlocProvider() {
  return MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(
        create: (_) => sl<AuthBloc>(),
      ),
      BlocProvider<InternetCubit>(
        create: (context) => sl<InternetCubit>(),
      ),
    ],
    child: const DashBoardPage(),
  );
}

MultiBlocProvider _getProfileBlocProvider() {
  return MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(
        create: (_) => sl<AuthBloc>(),
      ),
      BlocProvider<InternetCubit>(
        create: (context) => sl<InternetCubit>(),
      ),
    ],
    child: const ProfilePage(),
  );
}

MultiBlocProvider _getEditProfileBlocProvider() {
  return MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(
        create: (_) => sl<AuthBloc>(),
      ),
      BlocProvider<InternetCubit>(
        create: (context) => sl<InternetCubit>(),
      ),
    ],
    child: const EditProfilePage(),
  );
}

// MultiBlocProvider _getEditProfileBlocProvider() {
//   return MultiBlocProvider(
//     providers: [
//       BlocProvider<AuthBloc>(
//         create: (_) => sl<AuthBloc>(),
//       ),
//     ],
//     child: MultiProvider(
//       providers: [
//         ChangeNotifierProvider<UserProvider>(
//           create: (_) => sl<UserProvider>(),
//         ),
//         ChangeNotifierProvider<SettingsProvider>(
//           create: (_) => SettingsProvider(),
//         ),
//         // Add more providers as needed...
//       ],
//       child: const EditProfilePage(),
//     ),
//   );
// }

MultiBlocProvider _getSigInBlocProvider() {
  return MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(
        create: (_) => sl<AuthBloc>(),
      ),
      BlocProvider<InternetCubit>(
        create: (context) => sl<InternetCubit>(),
      ),
    ],
    child: const SignInPage(),
  );
}

MultiBlocProvider _getSigUpBlocProvider() {
  return MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => sl<AuthBloc>(),
      ),
      BlocProvider<InternetCubit>(
        create: (context) => sl<InternetCubit>(),
      ),
    ],
    child: const SignUpPage(),
  );
}

MultiBlocProvider _getOnBoardingBlocProvider() {
  return MultiBlocProvider(
    providers: [
      BlocProvider<SharedPreferencesCubitImpl>(
        create: (_) => sl<SharedPreferencesCubitImpl>(),
      ),
      BlocProvider<InternetCubit>(
        create: (context) => sl<InternetCubit>(),
      ),
    ],
    child: OnBoardingPage(),
  );
}

MultiBlocProvider _getSplashBlocProvider() {
  return MultiBlocProvider(
    providers: [
      BlocProvider<SharedPreferencesCubitImpl>(
        create: (_) => sl<SharedPreferencesCubitImpl>(),
      ),
    ],
    child: const SplashPage(),
  );
}

///Route the user according to the User object status
// MultiBlocProvider _routUserAccordingToLoginStatus(BuildContext context) {
//   final sharedPreferences = sl<SharedPreferences>();
//
//   /*check if it's the first time the user launching thee app */
//   if (sharedPreferences.getBool(kIsFirstTimeLoginKey) ?? true) {
//     return _getOnBoardingBlocProvider();
//   }
//   /*check if the user login status [signedOut,signedInUsingFireBase..]*/
//   if (sharedPreferences.containsKey(kLoginStatusTypeKey)) {
//     final loggedInBy = sharedPreferences.getString(kLoginStatusTypeKey) ??
//         LoginStatusEnum.signedOut.info.loginStatusType;
//     /*if the user signedout display signIn page]*/
//     if (loggedInBy == LoginStatusEnum.signedOut.info.loginStatusType) {
//       return _getSigInBlocProvider();
//     }
//     /*if the user signedInUsingFireBase
//           fetch user data and display dashboard page]*/
//     else if (loggedInBy ==
//         LoginStatusEnum.signedInUsingFireBase.info.loginStatusType) {
//       final fireBaseUser = sl<FirebaseAuth>().currentUser;
//       if (fireBaseUser != null) {
//         final userEntity = UserEntity(
//           uid: fireBaseUser.uid,
//           email: fireBaseUser.email ?? '',
//           points: 0,
//           displayName: fireBaseUser.displayName ?? '',
//         );
//
//         ///adding the signedIn user info into the Global Provider
//         /// so it can be accessed through all the app
//         context.read<UserProvider>().initUser(userEntity);
//         return _getDashboardBlocProvider();
//       } else {
//         return _getSigInBlocProvider();
//       }
//     }
//     /*(Bisher): handle the rest signedIn cases such
//              [emailPassword,facebook,google,iCloud]
//              instead of display signInPage*/
//     else {
//       return _getSigInBlocProvider();
//     }
//   }
//   /*the user isn't signedIn display signIn Page*/
//   else {
//     return _getSigInBlocProvider();
//   }
// }

//
// Widget _getDashboardBlocProvider() {
//
//   return const DashBoardPage();
//
// }
//
// Widget _getProfileBlocProvider() {
//
//   return const ProfilePage();
// }
//
// Widget _getEditProfileBlocProvider() {
//
//   return const EditProfilePage();
//
// }
// Widget _getSigInBlocProvider() {
//   return const SignInPage();
// }
//
// Widget _getSigUpBlocProvider() {
//   return const SignUpPage();
// }
//
// Widget _getOnBoardingBlocProvider() {
//   return const OnBoardingPage();
// }
//
// Widget _getSplashBlocProvider() {
//   return const SplashPage();
// }
