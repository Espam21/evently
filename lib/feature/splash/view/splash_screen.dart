import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:evently/core/app_colors.dart';
import 'package:evently/core/app_image.dart';
import 'package:evently/core/app_routes.dart';
import 'package:evently/core/app_style.dart';
import 'package:evently/core/app_text.dart';
import 'package:flutter/material.dart';

import '../../../core/preference/prefence.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateNext();
  }

  void _navigateNext() async {
    await Future.delayed(const Duration(seconds: 2));

    final savedLang = CacheHelper.getLang(key: 'lang');
    final savedTheme = CacheHelper.getTheme(key: 'theme');

    if (!mounted) return;

    if (savedLang != null && savedTheme != null) {
      Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.start);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: ElasticIn(
                    duration:Duration(milliseconds: 500),
                    child: Image.asset(ImageApp.appLogo)
                )),
                AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      AppText.evently,
                      textStyle: title,
                      colors: [
                        AppColors.primaryLight,
                        Colors.white,
                        AppColors.primaryLight,
                        AppColors.primaryLight,
                      ],
                    ),
                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                ),
              ],
            )),
            FadeInUp(
               delay: Duration(seconds: 1),
                child: Image.asset(ImageApp.routeLogo)),
          ],
        ),
      ),
    );
  }
}
