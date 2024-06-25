import 'package:education_app/config/routes/router.dart';
import 'package:education_app/config/theme/app_theme.dart';
import 'package:education_app/core/app/di/injection_container.dart';
import 'package:education_app/core/common/feature/localizationFromJSON/app_localizations_setup.dart';
import 'package:education_app/core/common/provider/settings_provider.dart';
import 'package:education_app/core/common/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  // _ApplicationPageState createState() => _ApplicationPageState();
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (_) => sl<UserProvider>(),
        ),
        ChangeNotifierProvider<SettingsProvider>(
          create: (_) => sl<SettingsProvider>(),
        ),
        // ChangeNotifierProvider<InternetConnectionProvider>(
        //   create: (_) => sl<InternetConnectionProvider>(),
        // ),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, _) {
          return MaterialApp.router(
            /*App Router*/
            routerConfig: goRouter,
            /*App Debug Label*/
            debugShowCheckedModeBanner: false,
            restorationScopeId: 'app',
            title: 'My First App',
            /*App Localization*/
            supportedLocales: AppLocalizationsSetup.supportedLocales,
            localizationsDelegates:
                AppLocalizationsSetup.localizationsDelegates,
            locale: settingsProvider.appLocal,
            //const Locale('en'),
            /*App theme*/
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: settingsProvider.appTheme,
            // themeMode: ThemeMode.dark,
          );
        },
      ),
    );
  }
}
