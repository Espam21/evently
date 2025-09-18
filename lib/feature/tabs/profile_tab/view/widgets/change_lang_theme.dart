import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/app_colors.dart';
import '../../../../../core/preference/cahce_key.dart';
import '../../../../../core/preference/prefence.dart';
import '../../../../../core/providers/providers.dart';
import '../../../../../l10n/app_localizations.dart';

class ChangeLangTheme extends ConsumerWidget {
  const ChangeLangTheme({super.key});

  @override
  Widget build(BuildContext context,ref) {
    var local = AppLocalizations.of(context)!;
    var locale = ref.watch(languageProvider);
    var themeMode = ref.watch(themeProvider);
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(local.language, style: theme.textTheme.titleMedium),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primaryLight),
            ),
            child: DropdownButton(
              hint: locale == 'en'
                  ? Text('english', style: theme.textTheme.bodyLarge)
                  : Text('arabic', style: theme.textTheme.bodyLarge),
              borderRadius: BorderRadius.circular(16),
              icon: Icon(Icons.arrow_drop_down_outlined,color: AppColors.primaryLight,),
              isExpanded: true,
              value: locale,
              underline: SizedBox.shrink(),
              items: languageModel
                  .map(
                    (lang) => DropdownMenuItem(
                  value: lang.langCode,
                  child: Text(
                    lang.langName,
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
              )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  ref.read(languageProvider.notifier).state = value;
                  CacheHelper.saveLang(key: CacheKeys.language, value: value);
                }
              },
            ),
          ),
          SizedBox(height: 24,),
          Text(local.theme, style: theme.textTheme.titleMedium),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primaryLight),
            ),
            child: DropdownButton<ThemeMode>(
              hint: themeMode == ThemeMode.light
                  ? Text('light', style: theme.textTheme.bodyLarge)
                  : Text('dark', style: theme.textTheme.bodyLarge),
              borderRadius: BorderRadius.circular(16),
              icon: Icon(Icons.arrow_drop_down_outlined, color: AppColors.primaryLight),
              isExpanded: true,
              value: themeMode, // ✅ Correct value
              underline: SizedBox.shrink(),
              items: [
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('light', style: theme.textTheme.bodyLarge),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('dark', style: theme.textTheme.bodyLarge),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  ref.read(themeProvider.notifier).state = value;
                  CacheHelper.saveTheme(key: CacheKeys.theme, value: value.toString());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
