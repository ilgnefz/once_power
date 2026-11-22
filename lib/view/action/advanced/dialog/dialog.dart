import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/model/actions.dart';
import 'package:once_power/widget/action/dot.dart';
import 'package:once_power/widget/base/dialog.dart';
import 'package:once_power/widget/base/text.dart';

import 'add.dart';
import 'delete.dart';
import 'replace.dart';

class AdvanceActionDialog extends StatefulWidget {
  const AdvanceActionDialog(this.action, {super.key});

  final PresetAction action;

  @override
  State<AdvanceActionDialog> createState() => _AdvanceActionDialogState();
}

class _AdvanceActionDialogState extends State<AdvanceActionDialog> {
  late PresetAction action;
  final double titleHeight = 24, dotHeight = 12;

  @override
  void initState() {
    action = widget.action;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EasyDialog(
      width: AppNumber.dialog,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // 高度预算必须和下面 Padding / 固定头部用同一份值，否则会差出
          // padding 的改动量（之前 Padding 改成 padding+medium 却漏改这里，
          // 导致撑满 bodyMaxHeight 的 add/replace 图片溢出 16px）。
          final double verticalPadding = AppNumber.padding;
          final double fixedHeight =
              titleHeight + dotHeight + AppNumber.spaceMedium;
          final double headerHeight = verticalPadding * 2 + fixedHeight;
          final double bodyMaxHeight = (constraints.maxHeight - headerHeight)
              .clamp(0.0, double.infinity)
              .toDouble();
          return Padding(
            padding: .symmetric(vertical: verticalPadding),
            child: Column(
              crossAxisAlignment: .center,
              mainAxisSize: .min,
              children: [
                SizedBox(
                  height: titleHeight,
                  child: BaseText(action.title, fontSize: 16),
                ),
                SizedBox(
                  height: dotHeight,
                  child: Row(
                    mainAxisAlignment: .center,
                    spacing: AppNumber.spaceSmall,
                    children: PresetAction.values.map((e) {
                      return DialogDot(
                        selected: action == e,
                        onTap: () => setState(() => action = e),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: AppNumber.spaceMedium),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: bodyMaxHeight),
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease,
                    alignment: Alignment.topCenter,
                    child: action.isDelete
                        ? const DeleteDialog()
                        : action.isAdd
                        ? const AddDialog()
                        : const ReplaceDialog(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
