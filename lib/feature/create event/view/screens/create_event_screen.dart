import 'package:evently/core/widgets/button_used.dart';
import 'package:evently/feature/create%20event/manger/create_event_screen_provider.dart';
import 'package:evently/feature/create%20event/view/widgets/custom_event_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';
import '../../../../core/providers/providers.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/catogray_tab_widget.dart';
import 'event_location_picker.dart';

class CreateEventScreen extends ConsumerStatefulWidget {
  const CreateEventScreen({super.key});

  @override
  ConsumerState<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends ConsumerState<CreateEventScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    final language = ref.watch(languageProvider);
    final theme = Theme.of(context);
    var local = AppLocalizations.of(context)!;
    final eventManager = EventManager();
    final selectedIndex = ref.watch(createEventTabIndex);
    final selectedCategory = filteredCategories[selectedIndex];
    final imagePath = themeMode == ThemeMode.dark
        ? selectedCategory.darkImage
        : selectedCategory.lightImage;
    return Scaffold(
      appBar: AppBar(title: Text('create event')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(imagePath ?? '', fit: BoxFit.cover),
              ),
              SizedBox(height: 16),
              SizedBox(
                height: 48,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final category = filteredCategories[index];
                    final isSelected = index == selectedIndex;
                    return GestureDetector(
                      onTap: () =>
                          ref.read(createEventTabIndex.notifier).state = index,
                      child: CatogeryTabWidget(
                        isSelected: isSelected,
                        catogray: category,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  itemCount: filteredCategories.length,
                ),
              ),
              SizedBox(height: 16),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('title', style: theme.textTheme.bodyMedium),
                    SizedBox(height: 8),
                    CustomEventTextField(
                      controller: titleController,
                      title: 'event title',
                      iconData: Icon(Icons.edit),
                    ),
                    SizedBox(height: 16),
                    Text('description', style: theme.textTheme.bodyMedium),
                    SizedBox(height: 8),
                    CustomEventTextField(
                      controller: desController,
                      title: 'event description',
                      lineNumber: 5,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      Icon(
                        Icons.calendar_month_rounded,
                        color: themeMode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      Text('event date', style: theme.textTheme.bodyMedium),
                    ],
                  ),
                  TextButton(
                    onPressed: () => eventManager.pickEventDate(context, ref),
                    child: Consumer(
                      builder: (context, ref, _) {
                        final selectedDate = ref.watch(
                          selectedEventDateProvider,
                        );
                        return Text(
                          selectedDate != null
                              ? 'Event Date: ${selectedDate.toLocal().toString().split(' ')[0]}'
                              : 'Choose Date',
                        );
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      Icon(Icons.watch_later_outlined, color: themeMode == ThemeMode.light
                          ? Colors.black
                          : Colors.white,),
                      Text('event time', style: theme.textTheme.bodyMedium),
                    ],
                  ),
                  TextButton(
                    onPressed: () => eventManager.pickEventTime(context, ref),
                    child: Consumer(
                      builder: (context, ref, _) {
                        final selectedTime = ref.watch(
                          selectedEventTimeProvider,
                        );
                        return Text(
                          selectedTime != null
                              ? 'Event Time: ${selectedTime.format(context)}'
                              : 'Choose Time',
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text('location', style: theme.textTheme.bodyMedium),
              SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: Consumer(
                  builder: (context, ref, _) {
                    final location = ref.watch(selectedEventLocationProvider);
                    final locationText = location != null
                        ? 'Lat: ${location.latitude}, Lng: ${location.longitude}'
                        : 'Choose Location';

                    return OutlinedButton.icon(
                      icon: const Icon(Icons.location_on_outlined),
                      label: Text(locationText),
                      onPressed: () async {
                        final result = await Navigator.push<LocationData?>(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const EventLocationPicker(),
                          ),
                        );
                        if (result != null) {
                          ref
                                  .read(selectedEventLocationProvider.notifier)
                                  .state =
                              result;
                        }
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ButtonUsed(
                  text: 'Create event',
                  onPress: () {
                    eventManager.addEvent(context, ref);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
