import 'package:evently/feature/home/manger/home_layout_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context,ref) {
    var local = AppLocalizations.of(context)!;
    var current=ref.watch(currentIndex);
    return BottomNavigationBar(
      currentIndex: current,
      onTap: (index){
        ref.read(currentIndex.notifier).state=index;
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: local.home
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: local.love
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            activeIcon: Icon(Icons.map),
            label: local.maps
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_sharp),
            activeIcon: Icon(Icons.person),
            label: local.profile
        ),
      ],
      type:BottomNavigationBarType.fixed,
    );
  }
}

