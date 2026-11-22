import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/icon.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/advance.dart';
import 'package:once_power/view/action/advanced/dialog/match_content.dart';
import 'package:once_power/view/action/advanced/dialog/match_position.dart';
import 'package:once_power/widget/action/dialog_item.dart';
import 'package:once_power/widget/action/input.dart';
import 'package:once_power/widget/action/item.dart';

class DeleteInputGroup extends StatelessWidget {
  const DeleteInputGroup({
    super.key,
    required this.selected,
    required this.value,
    required this.regex,
    required this.onIconPressed,
    required this.onChanged,
    required this.content,
    required this.onContentChanged,
    required this.number,
    required this.onNumberChanged,
    required this.position,
    required this.onPositionChanged,
    required this.front,
    required this.onFrontChanged,
    required this.behind,
    required this.onBehindChanged,
  });

  final bool selected;
  final String value;
  final bool regex;
  final void Function() onIconPressed;
  final void Function(String) onChanged;
  final MatchContent content;
  final void Function(MatchContent) onContentChanged;
  final int number;
  final void Function(int) onNumberChanged;
  final MatchPosition position;
  final void Function(MatchPosition) onPositionChanged;
  final int front;
  final void Function(int) onFrontChanged;
  final int behind;
  final void Function(int) onBehindChanged;

  @override
  Widget build(BuildContext context) {
    return SelectedBox(
      selected: selected,
      child: Column(
        crossAxisAlignment: .start,
        spacing: AppNumber.spaceMedium,
        children: [
          ActionItem(
            padding: .zero,
            icon: AppIcons.regex,
            tip: context.tr(AppL10n.regex),
            checked: regex,
            onIconPressed: onIconPressed,
            child: EasyInput(
              hintText: context.tr(AppL10n.match),
              value: value,
              onChanged: onChanged,
            ),
          ),
          MatchContentGroup(
            content: content,
            onChanged: onContentChanged,
            number: number,
            onNumberChanged: onNumberChanged,
          ),
          MatchPositionGroup(
            position: position,
            onChanged: onPositionChanged,
            front: front,
            onFrontChanged: onFrontChanged,
            behind: behind,
            onBehindChanged: onBehindChanged,
          ),
        ],
      ),
    );
  }
}
