import 'package:evently/feature/auth/data/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isPasswordProvider = StateProvider<bool>((ref) => true);
final isRePasswordProvider = StateProvider<bool>((ref) => true);


final authStateProvider = Provider<bool>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  final isValid = user != null && !user.isAnonymous;
  return isValid;
});

final signupProvider = AsyncNotifierProvider<SignUpNotifier, void>(
  () => SignUpNotifier(),
);

class SignUpNotifier extends AsyncNotifier<void> {
  @override
  void build() {}

  Future<void> signUp(String email, String password,String name) async {
    state = AsyncLoading();
    try {
      final result = await AuthFirebaseManger.createAccountEmail(email, password);

      if (result != null) {
        await result.user?.updateDisplayName(name);
        await result.user?.reload();
        state = AsyncData(null);
      } else {
        await FirebaseAuth.instance.signOut();
        state = AsyncError('Unknown error', StackTrace.current);
      }
    } catch (e, st) {
      await FirebaseAuth.instance.signOut();
      state = AsyncError(e, st);
    }
  }
}


final loginProvider=AsyncNotifierProvider<LoginNotifier,void>(
    ()=>LoginNotifier(),
);
class LoginNotifier extends AsyncNotifier<void>{
  @override
  void build()   {}
  Future<void> login(String email, String password) async {
    state = AsyncLoading();
    try {
      final result = await AuthFirebaseManger.loginWithEmail(
        email,
        password,
      );
      if (result != null) {
        state = AsyncData(null);
      } else {
        state = AsyncError('Login failed', StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}