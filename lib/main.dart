import 'package:education_app/core/app/di/injection_container.dart';
import 'package:education_app/core/common/presentation/page/application_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /*App Check helps protect your API resources from abuse by preventing
  unauthorized clients from accessing your backend resources. It works with
  both Firebase services, Google Cloud services,
  and your own APIs to keep your resources safe*/
  // await FirebaseAppCheck.instance.activate(
  //     // webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  //     );
  /*Pass all uncaught errors from the framework to Crashlytics.*/
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  await initializeDependencies();

  runApp(const ApplicationPage());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => UserProvider(),
//       child: MaterialApp.router(
//         title: 'My First App',
//         theme: ThemeData(
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//           useMaterial3: true,
//           fontFamily: AppFonts.POPPINS,
//           appBarTheme: const AppBarTheme(color: Colors.transparent),
//           colorScheme:
//               ColorScheme.fromSwatch(accentColor: AppColors.primaryColour),
//         ),
//         // onGenerateRoute: generateRoute,
//         routerConfig: goRouter,
//
//         // home: const UnderConstructionPage(),
//       ),
//     );
//   }
// }
