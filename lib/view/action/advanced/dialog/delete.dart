import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/advance.dart';
import 'package:once_power/view/action/advanced/dialog/button.dart';
import 'package:once_power/view/action/advanced/dialog/delete_extension.dart';
import 'package:once_power/view/action/advanced/dialog/delete_input.dart';
import 'package:once_power/view/action/advanced/dialog/delete_type.dart';
import 'package:once_power/view/action/advanced/dialog/match_part.dart';
import 'package:once_power/widget/action/mode_switch.dart';

class DeleteDialog extends StatefulWidget {
  const DeleteDialog({super.key});

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog>
    with AutomaticKeepAliveClientMixin {
  // TODO: 扩展删除自定义和全部、类型判断
  String value = '', group = '0';
  bool regex = false, deleteExtension = false;
  DeleteMode mode = DeleteMode.input;
  MatchContent content = MatchContent.number;
  MatchPosition position = MatchPosition.self;
  int number = 1, font = 1, behind = 1, start = 1, digit = 1;
  List<DeleteType> deleteTypes = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Localizations.localeOf(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        double widgetHeight = AppNumber.widgetHeight + AppNumber.spaceMedium;
        final double contentMax = (constraints.maxHeight - widgetHeight)
            .clamp(0.0, double.infinity)
            .toDouble();
        return Column(
          mainAxisSize: .min,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: contentMax),
              child: SingleChildScrollView(
                padding: .symmetric(horizontal: AppNumber.padding),
                child: Column(
                  // 不用 spacing：它会额外插到每对相邻 child（含 SizedBox）之间，
                  // 插入 SizedBox(h) 实际得到 h+8，导致每处间距得填不同值才视觉一致。
                  // 间距统一由下方 SizedBox 明确控制，所见即所得。
                  children: [
                    Row(
                      mainAxisAlignment: .center,
                      spacing: AppNumber.space,
                      children: DeleteMode.values.map((e) {
                        return ModeSwitchItem(
                          selected: mode == e,
                          label: e.label,
                          onTap: () => setState(() => mode = e),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: AppNumber.spaceMedium),
                    DeleteInputGroup(
                      selected: mode == DeleteMode.input,
                      value: value,
                      regex: regex,
                      onIconPressed: () {
                        regex = !regex;
                        mode = DeleteMode.input;
                        setState(() {});
                      },
                      onChanged: (value) {
                        value = value;
                        mode = DeleteMode.input;
                        setState(() {});
                      },
                      content: content,
                      onContentChanged: (value) {
                        content = value;
                        mode = DeleteMode.input;
                        setState(() {});
                      },
                      number: number,
                      onNumberChanged: (value) {
                        number = value;
                        mode = DeleteMode.input;
                        setState(() {});
                      },
                      position: position,
                      onPositionChanged: (value) {
                        position = value;
                        mode = DeleteMode.input;
                        setState(() {});
                      },
                      front: font,
                      onFrontChanged: (value) {
                        font = value;
                        mode = DeleteMode.input;
                        setState(() {});
                      },
                      behind: behind,
                      onBehindChanged: (value) {
                        behind = value;
                        mode = DeleteMode.input;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: AppNumber.spaceMedium),
                    MatchPartGroup(
                      selected: mode == DeleteMode.part,
                      start: start,
                      digit: digit,
                      onStartChanged: (value) {
                        start = value;
                        mode = DeleteMode.part;
                        setState(() {});
                      },
                      onDigitChanged: (value) {
                        digit = value;
                        mode = DeleteMode.part;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: AppNumber.spaceMedium),
                    DeleteTypeGroup(
                      selected: mode == DeleteMode.type,
                      deleteTypes: deleteTypes,
                      onChanged: (value) => setState(() {
                        deleteTypes.contains(value)
                            ? deleteTypes.remove(value)
                            : deleteTypes.add(value);
                        mode = DeleteMode.type;
                      }),
                      onAllChanged: (value) => setState(() {
                        deleteTypes = value
                            ? Set<DeleteType>.from(DeleteType.values).toList()
                            : [];
                        mode = DeleteMode.type;
                      }),
                    ),
                    DeleteExtensionGroup(
                      selected: mode == DeleteMode.extension,
                      extension: deleteExtension,
                      onExtensionChanged: (value) {
                        deleteExtension = value;
                        mode = DeleteMode.extension;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: AppNumber.spaceMedium),
            ButtonGroup(
              group: group,
              onComplete: () {},
              onCompleteExit: () {
                Navigator.of(context).pop();
              },
              onGroupChange: (value) => setState(() => group = value),
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
