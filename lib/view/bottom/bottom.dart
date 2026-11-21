import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/view/bottom/csv.dart';
import 'package:once_power/view/bottom/export.dart';
import 'package:once_power/view/bottom/progress.dart';
import 'package:once_power/view/bottom/setting.dart';
import 'package:once_power/view/bottom/view.dart';

import 'date.dart';
import 'save.dart';
import 'tv.dart';
import 'undo.dart';
import 'version.dart';

class BottomView extends ConsumerWidget {
  const BottomView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    // 当前实际生效的明暗决定读哪一组偏好；跟随系统时也跟着变。
    final bool transparent = theme.brightness == Brightness.light
        ? ref.watch(isLightTransparentProvider)
        : ref.watch(isDarkTransparentProvider);
    return Container(
      height: AppNumber.bottomBarHeight,
      padding: EdgeInsets.only(
        left: AppNumber.paddingMedium,
        right: AppNumber.padding,
      ),
      decoration: BoxDecoration(
        border: transparent
            ? null
            : Border(top: BorderSide(width: 1, color: theme.dividerColor)),
      ),
      child: Row(
        spacing: AppNumber.spaceSmall,
        children: const [
          SaveButton(),
          ViewButton(),
          TvButton(),
          CSVButton(),
          DateButton(),
          ExportButton(),
          SettingButton(),
          UndoButton(),
          Spacer(),
          ProgressButton(),
          SizedBox(width: 8),
          VersionButton(),
        ],
      ),
    );
  }
}
