import 'package:evently/core/app_routes.dart';
import 'package:evently/core/app_theme.dart';
import 'package:evently/core/preference/prefence.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/preference/cahce_key.dart';
import 'core/providers/providers.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  final savedLang = CacheHelper.getLang(key:  CacheKeys.language) ?? 'en';
  final savedTheme = CacheHelper.getTheme(key:  CacheKeys.theme) == 'ThemeMode.dark'
      ? ThemeMode.dark
      : ThemeMode.light;
  runApp(ProviderScope(
    overrides: [
      languageProvider.overrideWith((ref) => savedLang),
      themeProvider.overrideWith((ref) => savedTheme),
    ],
      child: const MyApp()
  ));


}
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    var theme = ref.watch(themeProvider);
    var local = ref.watch(languageProvider);
    return MaterialApp(
      title: 'event',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: theme,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale(local),
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
      ],
      debugShowCheckedModeBanner: false,
      routes:AppRoutes.routes,
      initialRoute: getIntialRoute(),
    );
  }
}
String getIntialRoute(){
  if(FirebaseAuth.instance.currentUser!=null){
    return AppRoutes.home;
  }else{
    return AppRoutes.start;
  }
}

