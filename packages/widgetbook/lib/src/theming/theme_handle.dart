import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/multi_render_handle.dart';
import 'package:widgetbook/src/theming/widgetbook_theme.dart';
import 'package:widgetbook/src/workbench/comparison_setting.dart';
import 'package:widgetbook/src/workbench/selection_item.dart';
import 'package:widgetbook/src/workbench/workbench_provider.dart';

class ThemeHandle<CustomTheme> extends ConsumerWidget {
  const ThemeHandle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workbenchProvider = context.watch<WorkbenchProvider<CustomTheme>>();
    final workbenchState = workbenchProvider.state;

    return ComparisonHandle<WidgetbookTheme<CustomTheme>, CustomTheme>(
      multiRender: ComparisonSetting.themes,
      items: workbenchState.themes,
      buildItem: (WidgetbookTheme<CustomTheme> e) => SelectionItem(
        name: e.name,
        selectedItem: workbenchState.theme,
        item: e,
        onPressed: () {
          workbenchProvider.changedTheme(e);
        },
      ),
      onPreviousPressed: workbenchProvider.previousTheme,
      onNextPressed: workbenchProvider.nextTheme,
    );
  }
}
