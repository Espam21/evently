import 'package:animate_do/animate_do.dart';
import 'package:evently/core/app_routes.dart';
import 'package:evently/core/app_style.dart';
import 'package:evently/core/app_text.dart';
import 'package:evently/core/preference/prefence.dart';
import 'package:evently/core/widgets/button_used.dart';
import 'package:evently/feature/start/view/widgets/toggle_row.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/app_image.dart';
import '../../../core/preference/cahce_key.dart';
import '../../../core/providers/providers.dart';

class StartScreen extends ConsumerWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var local=AppLocalizations.of(context)!;
    var locale=ref.watch(languageProvider);
    var themeMode = ref.watch(themeProvider);
    var theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  textDirection: TextDirection.ltr,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeInLeftBig(
                      child: Image.asset(ImageApp.appLogo, height: 55),
                    ),
                    FadeInRightBig(
                      child: Text(
                        AppText.evently,
                        style: title.copyWith(fontSize: 23),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Center(
                  child: themeMode == ThemeMode.light
                      ? Image.asset(ImageApp.onboardingFirstLight, width: 300)
                      : Image.asset(ImageApp.onboardingFirstDark, width: 300),
                ),
              ),
              Expanded(
                child: Text(
                  local.personalizeYourExperience,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
              Expanded(
                child: Text(
                  local.startText,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              Expanded(
                child: ToggleRow(
                  text: local.language,
                  value: locale,
                  values: ['ar', 'en'],
                  icons: [
                    Image.asset(ImageApp.arabicLanguage),
                    Image.asset(ImageApp.englishLanguage),
                  ],
                  onChange: (value){
                    ref.read(languageProvider.notifier).state=value;
                    CacheHelper.saveLang(key:  CacheKeys.language, value: value);
                  },
                ),
              ),
              Expanded(
                child: ToggleRow(
                  text: local.theme,
                  value: themeMode,
                  values: [ThemeMode.light, ThemeMode.dark],
                  icons: [
                    Image.asset(ImageApp.sunLight),
                    Image.asset(
                      ImageApp.moonDark,
                      color: themeMode == ThemeMode.dark ? Colors.white : null,
                    ),
                  ],
                  onChange: (value) {
                    ref.read(themeProvider.notifier).state = value;
                    CacheHelper.saveTheme(key:  CacheKeys.theme, value: value.toString());
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ButtonUsed(text: local.buttonStart,onPress: (){
                  final savedLang = CacheHelper.getLang(key: 'lang');
                  final savedTheme = CacheHelper.getTheme(key: 'theme');

                  if (savedLang == null) {
                    CacheHelper.saveLang(key: 'lang', value: locale);
                  }

                  if (savedTheme == null) {
                    CacheHelper.saveTheme(key: 'theme', value: themeMode.toString());
                  }

                  Navigator.pushNamed(context, AppRoutes.onboarding);

                },),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
