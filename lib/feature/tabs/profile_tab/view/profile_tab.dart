import 'package:evently/core/app_colors.dart';
import 'package:evently/core/app_image.dart';
import 'package:evently/feature/tabs/profile_tab/view/widgets/change_lang_theme.dart';
import 'package:evently/feature/tabs/profile_tab/view/widgets/profile_tab_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/preference/cahce_key.dart';
import '../../../../core/preference/prefence.dart';
import '../../../../core/providers/providers.dart';
import '../../../../l10n/app_localizations.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileTabHeader(),
        SizedBox(height: 24),
        ChangeLangTheme(),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: AppColors.lightBackground,
                minimumSize: Size(double.infinity, 56),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
                )
              ),
              child: Row(
                children: [
                  Icon(Icons.login_sharp,color: Colors.white,),
                  SizedBox(width: 8,),
                  Text('logout',style: TextStyle(color: Colors.white),)
                ],
              )
          ),
        ),
        SizedBox(height: 36),
      ],
    );
  }
}
