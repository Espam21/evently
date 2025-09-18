import 'package:animate_do/animate_do.dart';
import 'package:evently/core/app_routes.dart';
import 'package:evently/core/preference/cahce_key.dart';
import 'package:evently/core/validator/validator.dart';
import 'package:evently/core/widgets/button_used.dart';
import 'package:evently/feature/auth/manger/auth_listner.dart';
import 'package:evently/feature/auth/manger/auth_manger.dart';
import 'package:evently/feature/auth/view/widgets/text_form_field_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_image.dart';
import '../../../../core/app_style.dart';
import '../../../../core/app_text.dart';
import '../../../../core/preference/prefence.dart';
import '../../../../core/providers/providers.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../start/view/widgets/toggle_row.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(loginProvider);
      listenToLogin(context: context, ref: ref);
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    var locale = ref.watch(languageProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Center(
                    child: FadeInLeftBig(
                      child: Image.asset(ImageApp.appLogo, height: 100),
                    ),
                  ),
                  Center(
                    child: FadeInRightBig(
                      child: Text(
                        AppText.evently,
                        style: title.copyWith(fontSize: 36),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  TextFormFieldCustom(
                    isPassword: false,
                    controller: emailController,
                    validate: (value) => Validator.validateEmail(value),
                    text: local.email,
                    iconPre: Icons.email,
                    type: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 24),
                  Consumer(
                    builder: (context, ref, _) {
                      final isPassword = ref.watch(isPasswordProvider);
                      return TextFormFieldCustom(
                        controller: passwordController,
                        isPassword: isPassword,
                        validate: (value) => Validator.validatePassword(value),
                        type: TextInputType.visiblePassword,
                        text: local.password,
                        iconPre: Icons.lock,
                        icon: isPassword ? Icons.visibility_off : Icons.visibility,
                        isIconClicked: () {
                          ref.read(isPasswordProvider.notifier).state = !isPassword;
                        },
                      );
                    },
                  ),
                  SizedBox(height: 12),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      local.forgetPassword,
                      style: theme.textTheme.headlineMedium,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ButtonUsed(
                      text: local.login,
                      onPress: () async {
                        if (formKey.currentState!.validate()) {
                          await ref.read(loginProvider.notifier).login(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('something went wrong'),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        local.dontHaveAccount,
                        style: theme.textTheme.displayMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          ref.invalidate(signupProvider);
                          Navigator.pushNamed(context, AppRoutes.signUp);
                        },
                        child: Text(
                          local.createAccount,
                          style: theme.textTheme.headlineMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: AppColors.primaryLight),
                      ),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      elevation: 0,
                      fixedSize: Size(double.infinity, 60),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Image.asset(ImageApp.google, height: 24),
                        SizedBox(width: 10),
                        Text(
                          local.loginWithGoogle,
                          style: theme.textTheme.displayMedium!.copyWith(
                            fontSize: 20,
                            color: AppColors.primaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  ToggleRow(
                    value: locale,
                    values: ['ar', 'en'],
                    icons: [
                      Image.asset(ImageApp.arabicLanguage),
                      Image.asset(ImageApp.englishLanguage),
                    ],
                    onChange: (value) {
                      ref.read(languageProvider.notifier).state = value;
                      CacheHelper.saveLang(key: CacheKeys.language, value: value);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
