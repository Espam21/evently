import 'package:animate_do/animate_do.dart';
import 'package:evently/feature/auth/manger/auth_listner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/app_image.dart';
import '../../../../core/app_routes.dart';
import '../../../../core/app_style.dart';
import '../../../../core/app_text.dart';
import '../../../../core/preference/cahce_key.dart';
import '../../../../core/preference/prefence.dart';
import '../../../../core/providers/providers.dart';
import '../../../../core/validator/validator.dart';
import '../../../../core/widgets/button_used.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../start/view/widgets/toggle_row.dart';
import '../../manger/auth_manger.dart';
import '../widgets/text_form_field_custom.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repasswordController = TextEditingController();

  late ProviderSubscription<AsyncValue<void>> signupSub;

  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(signupProvider);
      signupSub = ref.listenManual(signupProvider, (previous, next) {
        next.whenOrNull(
          loading: () {
            showDialog(
              context: context,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          },
          data: (_) {
            if (Navigator.canPop(context)) Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text('Account created successfully'),
                backgroundColor: Colors.green,
                action: SnackBarAction(
                  label: 'ok',
                  onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                ),
              ),
            );
            ref.invalidate(loginProvider);
            Navigator.pushNamed(context, AppRoutes.login);
          },
          error: (err, _) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(err.toString()),
                backgroundColor: Colors.red,
                action: SnackBarAction(
                  label: 'ok',
                  onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                ),
              ),
            );
          },
        );
      });
    });
  }

  @override
  void dispose() {
    signupSub.close();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    repasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    var locale = ref.watch(languageProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text(local.register),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
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
                TextFormFieldCustom(
                  isPassword: false,
                  controller: nameController,
                  validate: (value) => Validator.validateName(value),
                  text: local.name,
                  iconPre: Icons.person,
                  type: TextInputType.name,
                ),
                SizedBox(height: 12),
                TextFormFieldCustom(
                  isPassword: false,
                  controller: emailController,
                  validate: (value) => Validator.validateEmail(value),
                  text: local.email,
                  iconPre: Icons.email,
                  type: TextInputType.emailAddress,
                ),
                SizedBox(height: 12),
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
                Consumer(
                  builder: (context, ref, _) {
                    final isPassword = ref.watch(isRePasswordProvider);
                    return TextFormFieldCustom(
                      controller: repasswordController,
                      isPassword: isPassword,
                      validate: (value) {
                        if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return Validator.validatePassword(value);
                      },
                      type: TextInputType.visiblePassword,
                      text: local.rePassword,
                      iconPre: Icons.lock,
                      icon: isPassword ? Icons.visibility_off : Icons.visibility,
                      isIconClicked: () {
                        ref.read(isRePasswordProvider.notifier).state = !isPassword;
                      },
                    );
                  },
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ButtonUsed(
                    text: local.createAccount,
                    onPress: () async {
                      ref.invalidate(loginProvider);
                      if (formKey.currentState!.validate()) {
                        await FirebaseAuth.instance.signOut();
                        await ref.read(signupProvider.notifier).signUp(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                          nameController.text.trim(),
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
                      local.alreadyHaveAccount,
                      style: theme.textTheme.displayMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.login);
                      },
                      child: Text(
                        local.login,
                        style: theme.textTheme.headlineMedium,
                      ),
                    ),
                  ],
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
    );
  }
}
