import 'package:evently/core/models/catogray_model.dart';
import 'package:evently/core/widgets/custom_event_widget.dart';
import 'package:evently/feature/home/manger/home_layout_manger.dart';
import 'package:evently/feature/tabs/home_tab/view/widgets/home_tab_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../manger/home_tab_provider.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return DefaultTabController(
      length: CatograyModel.catogries.length,
      child: Column(
        children: [
          HomeTabHeader(),
          SizedBox(height: 10),
          Expanded(
            child: Consumer(
              builder: (context, ref, _) {
                final selectedIndex = ref.watch(homeTabIndex);
                final selectedCategory = CatograyModel.catogries[selectedIndex];
                final categoryId = selectedCategory.id;
                final eventsAsync = ref.watch(
                  filteredEventsProvider(categoryId),
                );

                return eventsAsync.when(
                  data: (events) {
                    if (events.isEmpty) {
                      return Center(child: Text('No events found'));
                    }
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      itemBuilder: (context, index) => CustomEventWidget(
                        event: events[index],
                        onTap: () async {
                          await LayoutManger().toggleFav(events[index]);
                          ref.invalidate(
                            filteredEventsProvider(categoryId),
                          );
                          ref.invalidate(favEventsProvider);
                        },
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 12),
                      itemCount: events.length,
                    );
                  },
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (err, stack) =>
                      Center(child: Text('Error loading events')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
