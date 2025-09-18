import 'package:evently/core/app_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CatograyModel{
  final String id;
  final String title;
  final IconData icon;
  final String? lightImage;
  final String? darkImage;

  CatograyModel({required this.id, required this.title, required this.icon,  this.lightImage,  this.darkImage});

  static List<CatograyModel> catogries=[
    CatograyModel(
        id: '1',
        title: 'all',
        icon: Icons.all_inclusive
    ),
    CatograyModel(
        id: '2',
        title: 'sports',
        icon: Icons.sports,
        lightImage: ImageApp.sportLight,
        darkImage: ImageApp.sportDark,
    ),
    CatograyModel(
        id: '3',
        title: 'birthday',
        icon: Icons.cake,
        lightImage: ImageApp.birthdayLight,
        darkImage: ImageApp.birthdayDark,
    ),
    CatograyModel(
        id: '4',
        title: 'book club',
        icon: Icons.book,
        lightImage: ImageApp.bookLight,
        darkImage: ImageApp.bookDark,
    ),
    CatograyModel(
        id: '5',
        title: 'meeting',
        icon: Icons.meeting_room,
        lightImage: ImageApp.meetingLight,
        darkImage: ImageApp.meetingDark,
    ),
    CatograyModel(
        id: '6',
        title: 'gaming',
        icon: Icons.gamepad_outlined,
        lightImage: ImageApp.gamingLight,
        darkImage: ImageApp.gamingDark,
    ),
    CatograyModel(
        id: '7',
        title: 'eating',
        icon: Icons.fastfood,
        lightImage: ImageApp.eatingLight,
        darkImage: ImageApp.eatingDark,
    ),
    CatograyModel(
        id: '8',
        title: 'holiday',
        icon: Icons.holiday_village,
        lightImage: ImageApp.holidayLight,
        darkImage: ImageApp.holidayDark,
    ),
    CatograyModel(
        id: '9',
        title: 'exhibition',
        icon: Icons.art_track,
        lightImage: ImageApp.exhibitionLight,
        darkImage: ImageApp.exhibitionDark,
    ),
    CatograyModel(
        id: '10',
        title: 'work shop',
        icon: Icons.work_history_rounded,
        lightImage: ImageApp.workshopLight,
        darkImage: ImageApp.workshopDark,
    ),
  ];
}