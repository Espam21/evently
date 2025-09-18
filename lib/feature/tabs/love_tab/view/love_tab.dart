import 'package:evently/feature/tabs/love_tab/view/widgets/search_widget_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/catogray_model.dart';
import '../../../../core/widgets/custom_event_widget.dart';
import '../../../home/manger/home_layout_manger.dart';
import '../../home_tab/manger/home_tab_provider.dart';

class LoveTab extends ConsumerWidget {
  const LoveTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favEventsAsync = ref.watch(favEventsProvider);
    final selectedIndex = ref.watch(homeTabIndex);
    final selectedCategory = CatograyModel.catogries[selectedIndex];
    final categoryId = selectedCategory.id;
   

    return SafeArea(
      child: Column(
        children: [
          SearchWidgetCustom(),
          SizedBox(height: 10),
          Expanded(
            child: favEventsAsync.when(
              data: (events) {
                if (events.isEmpty) {
                  return Center(child: Text('No favorite events found'));
                }
                return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  itemBuilder: (context, index) => CustomEventWidget(
                    event: events[index],
                    onTap: () async {
                      await LayoutManger().toggleFav(events[index]);
                      ref.invalidate(favEventsProvider);
                      ref.invalidate(
                        filteredEventsProvider(categoryId),
                      );
                    },
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 12),
                  itemCount: events.length,
                );
              },
              loading: () => Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error loading favorites')),
            ),
          ),
        ],
      ),
    );
  }
}
