import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/dialog.dart';
import 'package:once_power/core/update/advance.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/provider/advance.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/src/rust/api/file_info.dart';
import 'package:once_power/widget/action/dynamic_button.dart';
import 'package:once_power/widget/base/text.dart';
import 'package:once_power/widget/common/click_icon.dart';

import 'add.dart';
import 'delete.dart';
import 'replace.dart';

final Widget _spaceM = SizedBox(width: AppNum.spaceMedium);
final Widget _spaceS = SizedBox(width: AppNum.spaceSmall);

class DirectiveItem extends ConsumerStatefulWidget {
  const DirectiveItem({super.key, required this.menu});

  final AdvanceMenuModel menu;

  @override
  ConsumerState<DirectiveItem> createState() => _DirectiveItemState();
}

class _DirectiveItemState extends ConsumerState<DirectiveItem> {
  bool isHover = false;

  Widget buildInfo() {
    switch (widget.menu.type) {
      case AdvanceType.delete:
        return DeleteCard(menu: widget.menu as AdvanceMenuDelete);
      case AdvanceType.add:
        return AddCard(menu: widget.menu as AdvanceMenuAdd);
      case AdvanceType.replace:
        return ReplaceCard(menu: widget.menu as AdvanceMenuReplace);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.read(advanceMenuListProvider.notifier);
    Color color = widget.menu.checked ? widget.menu.type.color : Colors.grey;
    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: InkWell(
        onTap: () {},
        borderRadius: .circular(AppNum.radiusSmall),
        mouseCursor: SystemMouseCursors.click,
        child: Container(
          height: AppNum.directiveHeight,
          padding: .only(left: AppNum.spaceMedium, right: AppNum.spaceSmall),
          decoration: BoxDecoration(
            borderRadius: .circular(AppNum.radiusSmall),
          ),
          child: Row(
            mainAxisSize: .max,
            crossAxisAlignment: .center,
            children: [
              BaseText(widget.menu.type.label, color: color),
              _spaceM,
              buildInfo(),
              _spaceM,
              DynamicButton(
                isHover: isHover,
                icon: widget.menu.checked
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                onPressed: () {
                  provider.toggle(widget.menu);
                  advanceUpdateName(ref);
                },
              ),
              _spaceS,
              DynamicButton(
                isHover: isHover,
                icon: Icons.copy_all_rounded,
                onPressed: () {
                  ref.read(currentPresetNameProvider.notifier).update('');
                  AdvanceMenuModel menu = widget.menu.copyWith(
                    id: generateId(),
                  );
                  provider.add(menu);
                  advanceUpdateName(ref);
                },
              ),
              _spaceS,
              DynamicButton(
                isHover: isHover,
                icon: Icons.edit_note_rounded,
                onPressed: () {
                  switch (widget.menu.type) {
                    case AdvanceType.delete:
                      deleteText(context, widget.menu as AdvanceMenuDelete);
                      break;
                    case AdvanceType.add:
                      addText(context, widget.menu as AdvanceMenuAdd);
                      break;
                    case AdvanceType.replace:
                      replaceText(context, widget.menu as AdvanceMenuReplace);
                      break;
                  }
                },
              ),
              ClickIcon(
                icon: Icons.close_rounded,
                size: 20,
                iconSize: 16,
                color: Colors.grey,
                onPressed: () {
                  ref.read(currentPresetNameProvider.notifier).update('');
                  provider.remove(widget.menu);
                  advanceUpdateName(ref);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
