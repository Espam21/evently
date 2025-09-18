import 'package:evently/feature/home/data/firestore/firestore_data_manger.dart';
import 'package:evently/feature/home/data/model/event_model.dart';
import 'package:evently/feature/tabs/home_tab/view/home_tab.dart';
import 'package:evently/feature/tabs/love_tab/view/love_tab.dart';
import 'package:evently/feature/tabs/map_tab/view/map_tab.dart';
import 'package:evently/feature/tabs/profile_tab/view/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final currentIndex=StateProvider<int>((ref)=>0);
final eventsProvider = FutureProvider((ref) => FireStoreData.getEvents());
final filteredEventsProvider = FutureProvider.family<List<EventModel>, String>((ref, categoryId) {
  return FireStoreData.getEvents(categoryId);
});

final favEventsProvider = FutureProvider<List<EventModel>>((ref) {
  return FireStoreData.getFav();
});

final List<Widget>tabs=[
  HomeTab(),
  LoveTab(),
  MapTab(),
  ProfileTab(),
];

class LayoutManger{
  Future<void>toggleFav(EventModel event)async{
    await FireStoreData.toggleFav(event);
  }
}

