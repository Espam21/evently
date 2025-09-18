import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/providers/providers.dart';

class CustomEventTextField extends ConsumerWidget {
  final String title;
  final Icon? iconData;
  final int? lineNumber;
  final TextEditingController? controller;

  const CustomEventTextField(
    {
    super.key,
    required this.title,
    this.lineNumber,
    this.controller,
      this.iconData,
  });

  @override
  Widget build(BuildContext context, ref) {
    final themeMode = ref.watch(themeProvider);
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      maxLines: lineNumber,
      decoration: InputDecoration(
        hintText: title,
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: themeMode == ThemeMode.light
              ? AppColors.darkGrey
              : AppColors.darkBodyText,
        ),
        prefixIcon: iconData,
        prefixIconColor: iconData != null ? AppColors.darkGrey : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.darkGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.darkGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.darkGrey),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.darkGrey),
        ),
      ),
    );
  }
}
