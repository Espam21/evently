import '../../../core/app_image.dart';
import '../../../l10n/app_localizations.dart';
import '../model/page_model.dart';

class PageData {
  static List<PageModel> getPages(AppLocalizations local) {
    return [
      PageModel(
        imageLight: ImageApp.onboarding1,
        imageDark: ImageApp.onboarding1,
        title: local.onBoardingOneTitle,
        body: local.onBoardingOneBody,
      ),
      PageModel(
        imageLight: ImageApp.onboardingLight2,
        imageDark: ImageApp.onboardingDark2,
        title: local.onBoardingTwoTitle,
        body: local.onBoardingTwoBody,
      ),
      PageModel(
        imageLight: ImageApp.onboardingLight3,
        imageDark: ImageApp.onboardingDark3,
        title: local.onBoardingThreeTitle,
        body: local.onBoardingThreeBody,
      ),
    ];
  }
}
