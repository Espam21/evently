import 'package:evently/core/app_routes.dart';
import 'package:evently/feature/home/data/firestore/firestore_data_manger.dart';
import 'package:evently/feature/home/manger/home_layout_manger.dart';
import 'package:evently/feature/home/view/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var index = ref.watch(currentIndex);
    return Scaffold(
      body: tabs[index],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.create);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
