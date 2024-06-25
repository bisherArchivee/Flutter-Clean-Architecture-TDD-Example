import 'package:education_app/config/theme/app_theme.dart';
import 'package:education_app/core/common/enum/router_pages_enum.dart';
import 'package:education_app/core/common/enum/sharedPreference_enum.dart';
import 'package:education_app/core/common/enum/snackbar_type_enum.dart';
import 'package:education_app/core/common/extension/context_builder_extension.dart';
import 'package:education_app/core/common/feature/internetConnection/presentaion/cubit/internet_cubit.dart';
import 'package:education_app/core/common/feature/internetConnection/presentaion/cubit/internet_state.dart';
import 'package:education_app/core/common/feature/sharedPreferences/presentation/cubit/sharedPreferences_cubit.dart';
import 'package:education_app/core/common/feature/sharedPreferences/presentation/cubit/sharedPreferences_state.dart';
import 'package:education_app/core/common/presentation/dialog/app_snackbar_dialog.dart';
import 'package:education_app/core/common/presentation/widget/rounded_button_widget.dart';
import 'package:education_app/core/common/presentation/widget/scroll_configuration_widget.dart';
import 'package:education_app/feature/on_boarding/domain/entity/on_boarding_content_entity.dart';
import 'package:education_app/feature/on_boarding/presentation/widget/on_boarding_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatelessWidget {
  OnBoardingPage({super.key});

  // static const routeName = '/';

  // @override
  // State<OnBoardingPage> createState() => _OnBoardingPageState();
// }

// class _OnBoardingPageState extends State<OnBoardingPage> {
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    // context.read<InternetConnectionProvider>().initInternetConnection();
    // final internetConnectionProvider = context.watch<InternetConnectionProvider>();
    //
    // if (!internetConnectionProvider.isConnectedToInternet) {
    //   // Handle no internet connection
    //   debugPrint('');
    // }
    final onBoardingPageFirstTitleLBL = context.appLocalizationEXT!
        .translate('_onBoardingPage_First_Title_LBL');
    final onBoardingPageFirstDescriptionLBL =
        context.appLocalizationEXT!.translate(
      '_onBoardingPage_First_Description_LBL',
    );

    final onBoardingPageSecondTitleLBL = context.appLocalizationEXT!
        .translate('_onBoardingPage_Second_Title_LBL');
    final onBoardingPageSecondDescriptionLBL =
        context.appLocalizationEXT!.translate(
      '_onBoardingPage_Second_Description_LBL',
    );

    final onBoardingPageThirdTitleLBL = context.appLocalizationEXT!
        .translate('_onBoardingPage_Third_Title_LBL');
    final onBoardingPageThirdDescriptionLBL =
        context.appLocalizationEXT!.translate(
      '_onBoardingPage_Third_Description_LBL',
    );

    final onBoardingPageGetStartedBTN =
        context.appLocalizationEXT!.translate('_onBoardingPage_GetStarted_BTN');

    final sharedPreferencesCubitImpl =
        BlocProvider.of<SharedPreferencesCubitImpl>(context);


    final snackBarCheckInternetSNK = context.appLocalizationEXT!
        .translate('_snackBar_No_Internet_SNK');

    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<SharedPreferencesCubitImpl, SharedPreferencesState>(
            listener: (context, state) {
              /*we have handled the user loggedIn Status inside the Router
               but in case the SharedPreferences has been
               failed we will handle it here*/

              if (state is GetStringSuccessState &&
                  state.keyValueMap.keys.first ==
                      SharedPrefLoginStatusEnum.signedOut.info.value) {
                // Navigator.
                // pushReplacementNamed(context, SignInPage.routeName);
                context.pushReplacementNamed(RouterPagesEnum.signIn.info.name);
                debugPrint('🟢CacheFirstTimeLogInSuccessState');
              }
            },
          ),BlocListener<InternetCubit,InternetState>(listener: (context, state) {
            debugPrint('🟡InternetCubitState');
            if (state is InternetDisconnected ) {
              // Handle no internet connection
              AppSnackBar.showSnackBar(
                context,
                snackBarCheckInternetSNK,
                SnackBarTypeEnum.error,
              );

            }
          },)
        ],
        // GradientBackgroundWidget
        child: BlocBuilder<SharedPreferencesCubitImpl, SharedPreferencesState>(
          builder: (context, state) {
            return SafeArea(
              child: AppScrollConfiguration(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          PageView(
                            controller: pageController,
                            children: [
                              OnBoardingBodyWidget(
                                onBoardingContentEntity:
                                OnBoardingContentEntity.first(
                                  title: onBoardingPageFirstTitleLBL,
                                  description:
                                  onBoardingPageFirstDescriptionLBL,
                                ),
                              ),
                              OnBoardingBodyWidget(
                                onBoardingContentEntity:
                                OnBoardingContentEntity.second(
                                  title: onBoardingPageSecondTitleLBL,
                                  description:
                                  onBoardingPageSecondDescriptionLBL,
                                ),
                              ),
                              OnBoardingBodyWidget(
                                onBoardingContentEntity:
                                OnBoardingContentEntity.third(
                                  title: onBoardingPageThirdTitleLBL,
                                  description:
                                  onBoardingPageThirdDescriptionLBL,
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: const Alignment(0, 0.04),
                            child: SmoothPageIndicator(
                              controller: pageController,
                              count: 3,
                              onDotClicked: (index) {
                                pageController.animateToPage(
                                  index,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              },
                              effect: WormEffect(
                                dotHeight: 10,
                                dotWidth: 10,
                                spacing: 40,
                                activeDotColor:
                                AppTheme.getThemePrimaryColor(context),
                                dotColor: Colors.grey[200]!,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (state is SetStringLoadingState)
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: RoundedButtonWidget(
                          buttonLabel: onBoardingPageGetStartedBTN,
                          buttonOnPressed: () async {
                            /*Navigate to login directly*/
                            if (context.mounted) {
                              context.pushReplacementNamed(
                                RouterPagesEnum.signIn.info.name,
                              );
                            }
                            debugPrint(
                              '🟡 CacheFirstTimeLogInSuccessState',
                            );
                            await sharedPreferencesCubitImpl.setStringCubit({
                              SharedPrefLoginStatusEnum
                                  .loginStatusKey.info.value:
                              SharedPrefLoginStatusEnum
                                  .signedOut.info.value,
                            });
                            debugPrint(
                              '🔵 CacheFirstTimeLogInSuccessState',
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            );

            // if (state is SetStringLoadingState) {
            //   return const LoadingView();
            // } else {

            // }
          },
        ),
      ),
    );
  }
}
