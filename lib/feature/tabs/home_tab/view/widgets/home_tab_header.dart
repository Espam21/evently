import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/app_colors.dart';
import '../../../../../core/models/catogray_model.dart';
import '../../../../../core/preference/cahce_key.dart';
import '../../../../../core/preference/prefence.dart';
import '../../../../../core/providers/providers.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../manger/home_tab_provider.dart';
import 'catogery_tab_item.dart';

class HomeTabHeader extends ConsumerWidget {
  const HomeTabHeader({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final themeMode = ref.watch(themeProvider);
    final language = ref.watch(languageProvider);
    final theme = Theme.of(context);
    var index = ref.watch(homeTabIndex);
    var local = AppLocalizations.of(context)!;
    return  Container(
      decoration: BoxDecoration(
        color: themeMode == ThemeMode.light
            ? AppColors.primaryLight
            : AppColors.darkBackground,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        local.welcomeback,
                        style: theme.textTheme.titleSmall,
                      ),
                      SizedBox(height: 5),
                      Text(
                        FirebaseAuth.instance.currentUser?.displayName ??
                            'user',
                        style: theme.textTheme.titleLarge,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          final isCurrentlyDark =
                              ref.read(themeProvider) == ThemeMode.dark;
                          final newTheme = isCurrentlyDark
                              ? ThemeMode.light
                              : ThemeMode.dark;

                          ref.read(themeProvider.notifier).state =
                              newTheme;
                          CacheHelper.saveTheme(
                            key: CacheKeys.theme,
                            value: newTheme.toString(),
                          );
                        },
                        icon: Icon(
                          Icons.wb_sunny_outlined,
                          color: AppColors.lightBackground,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          final currentLang = ref.read(languageProvider);
                          final newLang = currentLang == 'en'
                              ? 'ar'
                              : 'en';

                          ref.read(languageProvider.notifier).state =
                              newLang;
                          CacheHelper.saveLang(
                            key: CacheKeys.language,
                            value: newLang,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.lightBackground,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            local.en,
                            style: theme.textTheme.displaySmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_sharp,
                    color: AppColors.lightBackground,
                  ),
                  Text('cairo,egypt', style: theme.textTheme.titleSmall),
                ],
              ),
            ),
            SizedBox(height: 16),
            TabBar(
              isScrollable: true,
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,

              onTap: (index) {
                ref.read(homeTabIndex.notifier).state = index;
              },
              tabAlignment: TabAlignment.start,
              labelPadding: EdgeInsets.only(right: 16),
              padding: EdgeInsets.symmetric(horizontal: 16),
              tabs: CatograyModel.catogries
                  .map(
                    (e) =>
                    CatogeryTabItem(
                        isSelected: index==CatograyModel.catogries.indexOf(e),
                        catogray: e),
              )
                  .toList(),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
