import 'package:animate_do/animate_do.dart';
import 'package:evently/core/app_colors.dart';
import 'package:evently/core/app_image.dart';
import 'package:evently/feature/home/data/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';

class CustomEventWidget extends ConsumerWidget {
  final EventModel event;
  final void Function() onTap;

  const CustomEventWidget({
    super.key,
    required this.event,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, ref) {
    final themeMode = ref.watch(themeProvider);
    final theme = Theme.of(context);
    final dateParts = event.date.split('-');
    final day = dateParts.length > 2 ? dateParts[2] : '??';
    final month = dateParts.length > 1 ? dateParts[1] : '??';
    return Container(
      height: 220,
      width: double.infinity,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryLight, width: 1),
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(event.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: themeMode == ThemeMode.light
                  ? AppColors.darkWhite
                  : AppColors.darkBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  day,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryLight,
                  ),
                ),
                Text(
                  month,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryLight,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: themeMode == ThemeMode.light
                  ? AppColors.darkWhite
                  : AppColors.darkBlue,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  event.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: themeMode == ThemeMode.light
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: onTap,
                  child: event.fav
                      ? Bounce(child: Icon(Icons.favorite, color: AppColors.primaryLight))
                      : ZoomIn(
                        child: Icon(
                            Icons.favorite_border_outlined,
                            color: themeMode == ThemeMode.light
                                ? Colors.black
                                : Colors.white,
                          ),
                      ),
                ),
                SizedBox(width: 4,),
                ZoomIn(child: Text((event.users?.length??0).toString()))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
