import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app_colors.dart';
import '../../../../../core/app_image.dart';

class ProfileTabHeader extends StatelessWidget {
  const ProfileTabHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(64)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Container(
              height: 124,
              width: 124,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(1000),
                  bottomRight: Radius.circular(1000),
                  topRight: Radius.circular(1000),
                ),
                image: DecorationImage(image: AssetImage(ImageApp.appLogo)),
              ),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  FirebaseAuth.instance.currentUser?.displayName ?? 'user',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.lightBackground,
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  FirebaseAuth.instance.currentUser?.email ?? 'email',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightBackground,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
