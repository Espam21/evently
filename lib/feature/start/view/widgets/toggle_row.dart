import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_image.dart';
import '../../../../core/app_style.dart';
import '../../../../core/app_text.dart';

class ToggleRow extends StatelessWidget {
  final String? text;
  final dynamic value;
  final List<dynamic> values;
  final List<Widget> icons;
  final Function(dynamic)? onChange;

  const ToggleRow({
    super.key,
    this.text,
    required this.value,
    required this.values,
    required this.icons,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final toggle = AnimatedToggleSwitch<dynamic>.rolling(
      textDirection: TextDirection.rtl,
      current: value,
      values: values,
      iconList: icons,
      style: ToggleStyle(
        backgroundColor: Colors.transparent,
        borderColor: AppColors.primaryLight,
        indicatorColor: AppColors.primaryLight,
      ),
      onChanged: onChange,
    );

    return Row(
      textDirection: TextDirection.rtl,
      children: [
        if (text != null) ...[
          Text(
            text!,
            style: titleStartFirst.copyWith(fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          toggle,
        ] else ...[
          const Spacer(),
          toggle,
          const Spacer(),
        ],
      ],
    );
  }
}
