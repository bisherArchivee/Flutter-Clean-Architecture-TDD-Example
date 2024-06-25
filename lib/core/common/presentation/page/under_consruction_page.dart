import 'package:education_app/config/theme/app_media_res.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UnderConstructionPage extends StatelessWidget {
  const UnderConstructionPage({super.key});

  @override
  Widget build(BuildContext context) {
    //GradientBackgroundWidget
    return Scaffold(
      body: Lottie.asset(MediaRes.underConstructionPage),
    );
  }
}
