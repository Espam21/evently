import 'package:evently/core/models/catogray_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/app_colors.dart';
import '../../../../../core/providers/providers.dart';

class CatogeryTabItem extends ConsumerWidget {
  final bool isSelected;
  final CatograyModel catogray;
  const CatogeryTabItem({super.key, required this.isSelected, required this.catogray});

  @override
  Widget build(BuildContext context,ref) {
    final themeMode = ref.watch(themeProvider);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
      decoration: BoxDecoration(
        color:themeMode==ThemeMode.light?isSelected?AppColors.lightBackground:Colors.transparent:isSelected?AppColors.primaryLight:Colors.transparent,
        border:themeMode==ThemeMode.light?Border.all(color: AppColors.lightBackground,width: 2):Border.all(color: AppColors.primaryLight,width: 2),
        borderRadius: BorderRadius.circular(1000),
      ),
      child: Row(
        spacing: 8,
        children: [
          Icon(catogray.icon,color:themeMode==ThemeMode.light?isSelected?AppColors.primaryLight:AppColors.lightBackground:AppColors.lightBackground,),
          Text(catogray.title,style: TextStyle(
            color:themeMode==ThemeMode.light?isSelected?AppColors.primaryLight:AppColors.lightBackground:AppColors.lightBackground,
            fontSize: 16,
            fontWeight: FontWeight.w500
          ),)
        ],
      ),
    );
  }
}
