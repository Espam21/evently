import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/app_routes.dart';
import 'auth_manger.dart';

void listenToSignUp({required BuildContext context, required WidgetRef ref}) {
  ref.listenManual<AsyncValue<void>>(signupProvider, (previous, next) {
    next.whenOrNull(
      loading: () {
        showDialog(
          context: context,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        );
      },
      data: (_) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: 'ok',
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
            content: Text('Account created successfully '),
            backgroundColor: Colors.green,
          ),
        );
        ref.invalidate(loginProvider);
        Navigator.pushNamed(context, AppRoutes.login);
      },
      error: (err, _) {
       // Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: 'ok',
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
            content: Text(err.toString()),
            backgroundColor: Colors.red,
          ),
        );
      },
    );
  });
}
void listenToLogin({required BuildContext context, required WidgetRef ref}) {
  ref.listenManual<AsyncValue<void>>(loginProvider, (previous, next) {
    if (previous == null && next.hasValue && !next.isLoading) return;
    next.whenOrNull(
      loading: () {
        showDialog(
          context: context,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        );
      },
      data: (_) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: 'ok',
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
            content: Text('login successfully'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushNamed(context, AppRoutes.home);
      },
      error: (err, _) {
       /* if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }*/
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: 'ok',
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
            content: Text(err.toString()),
            backgroundColor: Colors.red,
          ),
        );
      },
    );
  });
}
