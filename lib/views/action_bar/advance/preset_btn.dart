import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/advance.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/advance_menu.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/widgets/common/click_icon.dart';
import 'package:once_power/widgets/common/one_line_text.dart';
import 'package:tolyui_feedback/toly_popover/toly_popover.dart';
import 'package:tolyui_feedback/toly_tooltip/tooltip_placement.dart';

class PresetBtn extends ConsumerWidget {
  const PresetBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextStyle btnStyle = TextStyle(
      fontSize: 13,
      color: Theme.of(context).primaryColor,
    ).useSystemChineseFont();

    List<AdvancePreset> list = ref.watch(advancePresetListProvider);

    return TolyPopover(
      placement: Placement.top,
      overlayBuilder: (context, ctrl) {
        void onTap(List<AdvanceMenuModel> list) {
          ctrl.close();
          List<AdvanceMenuModel> menus = [];
          menus.addAll(list);
          ref.read(advanceMenuListProvider.notifier).setList(menus);
          advanceUpdateName(ref);
        }

        void onRemove(AdvancePreset preset) {
          ctrl.close();
          ref.read(advancePresetListProvider.notifier).remove(preset);
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Material(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...List.generate(
                  list.length,
                  (index) {
                    return PresetOptionItem(
                      '${index + 1}. ${list[index].name}',
                      key: ValueKey(list[index].id),
                      onTap: () => onTap(list[index].menus),
                      onRemove: () => onRemove(list[index]),
                    );
                  },
                ),
                Ink(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      ctrl.close();
                      addPreset(context, ref);
                    },
                    child: Container(
                      height: AppNum.presetMenuItemH,
                      width: AppNum.presetMenuW,
                      alignment: Alignment.center,
                      child: Text(S.of(context).addPreset, style: btnStyle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      builder: (_, ctrl, __) {
        return TextButton(
          onPressed: ctrl.open,
          child: Text(S.of(context).preset),
        );
      },
    );
  }
}

class PresetOptionItem extends StatelessWidget {
  const PresetOptionItem(
    this.label, {
    super.key,
    required this.onTap,
    required this.onRemove,
  });

  final String label;
  final void Function() onTap;
  final void Function() onRemove;

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          height: AppNum.presetMenuItemH,
          width: AppNum.presetMenuW,
          color: Colors.transparent,
          // alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OneLineText(
                label,
                style: TextStyle(fontSize: 13).useSystemChineseFont(),
              ),
              ClickIcon(
                size: 16,
                iconSize: 14,
                icon: Icons.close_rounded,
                color: Colors.grey[400],
                onTap: onRemove,
              )
            ],
          ),
        ),
      ),
    );
  }
}
