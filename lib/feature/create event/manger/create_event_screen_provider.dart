import 'package:evently/feature/home/data/firestore/firestore_data_manger.dart';
import 'package:evently/feature/home/data/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

import '../../../core/models/catogray_model.dart';



final filteredCategories = CatograyModel.catogries.sublist(1);

final createEventTabIndex=StateProvider<int>((ref)=>0);
final selectedEventLocationProvider = StateProvider<LocationData?>((ref) => null);
final selectedEventDateProvider = StateProvider<DateTime?>((ref) => null);
final selectedEventTimeProvider = StateProvider<TimeOfDay?>((ref) => null);
TextEditingController titleController= TextEditingController();
TextEditingController desController= TextEditingController();

class EventManager {
  Future<void> pickEventDate(BuildContext context, WidgetRef ref) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (selectedDate != null) {
      ref.read(selectedEventDateProvider.notifier).state = selectedDate;
    }
  }
  Future<void>pickEventTime(BuildContext context,WidgetRef ref)async{
    final TimeOfDay? selectedTime= await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    );
    if(selectedTime!=null){
      ref.read(selectedEventTimeProvider.notifier).state=selectedTime;
    }
  }

  Future<void>addEvent(BuildContext context,WidgetRef ref)async{
   final selectedTime = ref.watch(selectedEventTimeProvider);
   final selectedDate = ref.watch(selectedEventDateProvider);
   final selectedIndex=ref.watch(createEventTabIndex);
   final selectedCategory = filteredCategories[selectedIndex];
   if (selectedDate == null || selectedTime == null) {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('Please select both date and time')),
     );
     return;
   }
   final formattedDate = selectedDate.toIso8601String().split('T')[0];
   final formattedTime = selectedTime.format(context);

   EventModel event=EventModel(
        title: titleController.text,
        des: desController.text,
        image: selectedCategory.darkImage ?? '',
        date: formattedDate,
        time: formattedTime,
        categoryId: selectedCategory.id,

   );
   await FireStoreData.addEvent(event);
   Navigator.pop(context);
  }

}