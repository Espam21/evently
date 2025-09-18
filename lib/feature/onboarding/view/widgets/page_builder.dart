import 'package:evently/feature/onboarding/model/page_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/providers.dart';

class PageBuilder extends ConsumerWidget {
  final PageModel model;

  const PageBuilder({super.key, required this.model});

  @override
  Widget build(BuildContext context, ref) {
    final themeMode = ref.watch(themeProvider);
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Center(
            child: Image.asset(
              themeMode == ThemeMode.dark ? model.imageDark : model.imageLight,
            ),
          ),
        ),
        SizedBox(height: 10,),
        Expanded(child: Text(model.title,style:theme.textTheme.bodyLarge ,)),
        Expanded(child: Text(model.body,style: theme.textTheme.bodyMedium,))
      ],
    );
  }
}
