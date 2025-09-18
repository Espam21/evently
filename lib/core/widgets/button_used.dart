import 'package:evently/core/app_colors.dart';
import 'package:evently/core/app_style.dart';
import 'package:flutter/material.dart';

class ButtonUsed extends StatelessWidget {
  final String text;
  final void Function()? onPress;
  const ButtonUsed({super.key, required this.text, this.onPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: AppColors.primaryLight,
        ),
        onPressed: onPress,
        child: Text(text,style: buttonStyle,)
    );
  }
}
