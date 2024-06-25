import 'package:education_app/core/common/presentation/widget/scroll_configuration_widget.dart';
import 'package:education_app/feature/profile/presentation/widget/profile_app_bar_widget.dart';
import 'package:education_app/feature/profile/presentation/widget/profile_header_widget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      // backgroundColor: Colors.white,
      appBar: const ProfileAppBarWidget(),
      body: AppScrollConfiguration(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: const [
            ProfileHeaderWidget(),
          ],
        ),
      ),
    );
  }
}
