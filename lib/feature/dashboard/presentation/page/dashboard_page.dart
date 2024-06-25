import 'package:education_app/core/common/enum/router_pages_enum.dart';
import 'package:education_app/core/common/enum/snackbar_type_enum.dart';
import 'package:education_app/core/common/extension/context_builder_extension.dart';
import 'package:education_app/core/common/feature/internetConnection/presentaion/cubit/internet_cubit.dart';
import 'package:education_app/core/common/feature/internetConnection/presentaion/cubit/internet_state.dart';
import 'package:education_app/core/common/presentation/dialog/app_snackbar_dialog.dart';
import 'package:education_app/core/common/provider/user_provider.dart';
import 'package:education_app/feature/authentication/domain/entity/auth_user_entity.dart';
import 'package:education_app/feature/dashboard/utils/dashboard_utils.dart';
import 'package:education_app/feature/profile/presentation/page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  // static const routeName = '/dashboard';

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  int _currentIndex = 0;
  late final snackBarCheckInternetSNK =
      context.appLocalizationEXT!.translate('_snackBar_No_Internet_SNK');

  // late final String _homePageTitleLBL =
  // context.appLocalizationEXT!.translate('_homePage_Title_LBL');

  final List<Widget> _pages = [
    // Define your pages/screens here
    const FirstPage(),
    const SecondPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    /*🚩here we have added StreamBuilder to
     keep listening to the firebase DataStore updates*/
    return MultiBlocListener(
      listeners: [
        BlocListener<InternetCubit, InternetState>(
          listener: (context, state) {
            debugPrint('🟡InternetCubitState');
            if (state is InternetDisconnected) {
              // Handle no internet connection
              AppSnackBar.showSnackBar(
                context,
                snackBarCheckInternetSNK,
                SnackBarTypeEnum.error,
              );
            }
          },
        ),
      ],
      child: StreamBuilder<UserEntity>(
        stream: DashboardUtils.userDataStream,
        builder: (_, snapshot) {
          /*if the received stream cloud data storage != our local
          UserEntity update the Local UserEntity*/
          if (snapshot.hasData && snapshot.data is UserEntity) {
            context.read<UserProvider>().userEntity = snapshot.data;
          }
          return Scaffold(
            body: _pages[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              // backgroundColor: Colors.white,
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: '_Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: '_Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: '_Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16).copyWith(top: 56),
          child: Column(
            children: [
              const Text('Home Page'),
              TextButton(
                onPressed: () =>
                    context.goNamed(RouterPagesEnum.signIn.info.name),
                child: const Text('🆑Sign in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Search Page'),
    );
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Profile Page'),
    );
  }
}
