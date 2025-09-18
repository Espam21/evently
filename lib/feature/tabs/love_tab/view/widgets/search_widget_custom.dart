import 'package:evently/core/app_colors.dart';
import 'package:flutter/material.dart';

import '../../manger/love_tab_manger.dart';

class SearchWidgetCustom extends StatelessWidget {
  const SearchWidgetCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        cursorColor: AppColors.primaryLight,
        controller: searchControllerProvider,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: AppColors.primaryLight),
          hintText: 'search for event',
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryLight,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.primaryLight, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.primaryLight, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.primaryLight, width: 1),
          ),
        ),
      ),
    );
  }
}
