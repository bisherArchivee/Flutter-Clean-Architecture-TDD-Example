// import 'dart:html' as html;
import 'dart:io';

import 'package:education_app/config/theme/app_media_res.dart';
import 'package:education_app/core/common/enum/router_pages_enum.dart';
import 'package:education_app/core/common/enum/sharedPreference_enum.dart';
import 'package:education_app/core/common/extension/context_builder_extension.dart';
import 'package:education_app/core/common/feature/sharedPreferences/presentation/cubit/sharedPreferences_cubit.dart';
import 'package:education_app/core/common/feature/sharedPreferences/presentation/cubit/sharedPreferences_state.dart';
import 'package:education_app/core/common/provider/settings_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:universal_html/html.dart' as html; // splash_web_page.dart

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 0),
      () async {
        await BlocProvider.of<SharedPreferencesCubitImpl>(context)
            .getStringCubit(
          SharedPrefAppLanguageEnum.appLanguageKey.info.value,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final onBoardingCubit = BlocProvider.of<OnBoardingCubit>(context);
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<SharedPreferencesCubitImpl, SharedPreferencesState>(
            listener: (context, state) async {
              /*check App Language Status State*/
              if (state is GetStringSuccessState &&
                  state.keyValueMap.keys.first ==
                      SharedPrefAppLanguageEnum.appLanguageKey.info.value) {
                if (state.keyValueMap.values.first ==
                    SharedPrefAppLanguageEnum.arabic.info.value) {
                  context.read<SettingsProvider>().appLocal =
                      Locale(SharedPrefAppLanguageEnum.arabic.info.value);
                } else if (state.keyValueMap.values.first ==
                    SharedPrefAppLanguageEnum.english.info.value) {
                  context.read<SettingsProvider>().appLocal =
                      Locale(SharedPrefAppLanguageEnum.english.info.value);
                } else {
                  /*get os language*/
                  final defaultLocale =
                      getOSAppLanguage(); // Returns locale string in the form 'en_US'
                  if (defaultLocale
                      .contains(SharedPrefAppLanguageEnum.arabic.info.value)) {
                    context.read<SettingsProvider>().appLocal =
                        Locale(SharedPrefAppLanguageEnum.arabic.info.value);
                  } else if (defaultLocale
                      .contains(SharedPrefAppLanguageEnum.english.info.value)) {
                    context.read<SettingsProvider>().appLocal =
                        Locale(SharedPrefAppLanguageEnum.english.info.value);
                  } else {
                    /*if OS language not supported
                     default language will be English*/
                    context.read<SettingsProvider>().appLocal =
                        Locale(SharedPrefAppLanguageEnum.english.info.value);
                  }
                }

                await BlocProvider.of<SharedPreferencesCubitImpl>(context)
                    .getStringCubit(
                  SharedPrefAppThemeEnum.darkThemeKey.info.value,
                );
              }
              /*check App Theme State*/
              else if (state is GetStringSuccessState &&
                  state.keyValueMap.keys.first ==
                      SharedPrefAppThemeEnum.darkThemeKey.info.value) {
                if (state.keyValueMap.values.first ==
                    SharedPrefAppThemeEnum.dark.info.value) {
                  context.read<SettingsProvider>().appTheme = ThemeMode.dark;
                } else if (state.keyValueMap.values.first ==
                    SharedPrefAppThemeEnum.light.info.value) {
                  context.read<SettingsProvider>().appTheme = ThemeMode.light;
                } else {
                  /*get os theme*/
                  // final currentBrightness =
                  //     MediaQuery.of(context).platformBrightness;
                  final getAppTheme = getOSAppTheme();
                  // Check if the current theme is dark or light
                  if (getAppTheme == ThemeMode.dark) {
                    context.read<SettingsProvider>().appTheme = ThemeMode.dark;
                  } else {
                    /*if OS theme not selected before
                     default will be light*/
                    context.read<SettingsProvider>().appTheme = ThemeMode.light;
                  }
                }

                await BlocProvider.of<SharedPreferencesCubitImpl>(context)
                    .getStringCubit(
                  SharedPrefLoginStatusEnum.loginStatusKey.info.value,
                );
              }

              /*check User Login Status State*/
              else if (state is GetStringSuccessState &&
                  state.keyValueMap.keys.first ==
                      SharedPrefLoginStatusEnum.loginStatusKey.info.value) {
                if (state.keyValueMap.values.first ==
                    SharedPrefLoginStatusEnum.loginStatusKey.info.value) {
                  if (context.mounted) {
                    context.pushReplacementNamed(
                      RouterPagesEnum.onboarding.info.name,
                    );
                  }
                } else if (state.keyValueMap.values.first ==
                    SharedPrefLoginStatusEnum.signedOut.info.value) {
                  if (context.mounted) {
                    context.pushReplacementNamed(
                      RouterPagesEnum.signIn.info.name,
                    );
                  }
                } else {
                  if (context.mounted) {
                    context.pushReplacementNamed(
                      RouterPagesEnum.dashboard.info.name,
                    );
                  }
                }
              }
            },
          ),
        ],
        // GradientBackgroundWidget
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset(
              MediaRes.turquoisePotPlant,
              height: context.heightEXT * 0.4,
            ),
          ],
        ),
      ),
    );
  }

  String getOSAppLanguage() {
    String? defaultLocale = SharedPrefAppLanguageEnum.english.info.value;
    if (kIsWeb) {
      // Get the user's preferred language
      defaultLocale = html.window.navigator.language;
        } else if (Platform.isAndroid || Platform.isIOS) {
      defaultLocale = Platform.localeName;
    } else {
      defaultLocale = SharedPrefAppLanguageEnum.english.info.value;
    }
    return defaultLocale!;
  }

  ThemeMode getOSAppTheme() {
    var themeMode = ThemeMode.light;
    if (kIsWeb) {
      // Check the preferred color scheme
      final isDark =
          html.window.matchMedia('(prefers-color-scheme: dark)').matches;
      if (isDark) {
        themeMode = ThemeMode.dark;
      } else {
        themeMode = ThemeMode.light;
      }
        } else if (Platform.isAndroid || Platform.isIOS) {
      final currentBrightness = MediaQuery.of(context).platformBrightness;
      // Check if the current theme is dark or light
      if (currentBrightness == Brightness.dark) {
        themeMode = ThemeMode.dark;
      } else {
        /*if OS theme not selected before
                     default will be light*/
        themeMode = ThemeMode.light;
      }
    }
    return themeMode;
  }
}
