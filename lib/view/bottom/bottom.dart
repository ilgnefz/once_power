import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
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

class BottomView extends StatelessWidget {
  const BottomView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      height: AppNumber.bottomBarHeight,
      padding: EdgeInsets.only(
        left: AppNumber.paddingMedium,
        right: AppNumber.padding,
      ),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 1, color: theme.dividerColor)),
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
