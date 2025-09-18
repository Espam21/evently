import 'package:evently/feature/auth/view/screens/login_screen.dart';
import 'package:evently/feature/auth/view/screens/sign_up_screen.dart';
import 'package:evently/feature/create%20event/view/screens/create_event_screen.dart';
import 'package:evently/feature/home/view/screens/home_screen.dart';
import 'package:evently/feature/splash/view/splash_screen.dart';
import 'package:evently/feature/start/view/start_screen.dart';
import 'package:flutter/material.dart';

import '../feature/onboarding/view/screens/onboarding_screen.dart';

class AppRoutes{
  static const String splash='/';
  static const String start='/start';
  static const String onboarding='/onboarding';
  static const String signUp='/signUp';
  static const String login='/login';
  static const String home='/home';
  static const String create='/create';

  static  Map<String, Widget Function(BuildContext)> routes={
    splash:(_)=> SplashScreen(),
    start:(_)=> StartScreen(),
    onboarding:(_)=>OnboardingScreen(),
    signUp:(_)=>SignUpScreen(),
    login:(_)=>LoginScreen(),
    home:(_)=>HomeScreen(),
    create:(_)=>CreateEventScreen(),
  };
}