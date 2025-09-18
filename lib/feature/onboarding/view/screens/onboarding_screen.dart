import 'package:animate_do/animate_do.dart';
import 'package:evently/core/app_routes.dart';
import 'package:evently/feature/onboarding/view/widgets/page_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/app_image.dart';
import '../../../../core/app_style.dart';
import '../../../../core/app_text.dart';
import '../../../../core/providers/providers.dart';
import '../../../../l10n/app_localizations.dart';
import '../../model/page_model.dart';
import '../../page_data/page_data.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    final pages = PageData.getPages(local);
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
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
            flex: 6,
            child: PageView.builder(
              controller: _pageController,
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return PageBuilder(model: pages[index]);
              },
            ),
          ),

          // Navigation Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPage > 0)
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ],
                  )
                else
                  const SizedBox(),
                if (_currentPage < pages.length - 1)
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ],
                  )
                else
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}