import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/icons.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/update/advance.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/provider/advance.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/src/rust/api/file_info.dart';
import 'package:once_power/util/verify.dart';
import 'package:once_power/view/action/advance/dialog/delete_extension.dart';
import 'package:once_power/view/action/advance/dialog/group_dropdown.dart';
import 'package:once_power/view/action/advance/dialog/match_content.dart';
import 'package:once_power/widget/action/item.dart';
import 'package:once_power/widget/base/dialog.dart';
import 'package:once_power/widget/common/input_field.dart';

import 'delete_type.dart';

class DeleteView extends ConsumerStatefulWidget {
  const DeleteView({super.key, this.menu});

  final AdvanceMenuDelete? menu;

  @override
  ConsumerState<DeleteView> createState() => _DeleteViewState();
}

class _DeleteViewState extends ConsumerState<DeleteView> {
  String value = '', group = 'all';
  MatchContent content = MatchContent.first;
  int number = 1, front = 1, behind = 1, start = 1, end = 1;
  List<DeleteType> deleteTypes = [];
  bool deleteExtension = false, useRegex = false;

  @override
  void initState() {
    super.initState();
    if (widget.menu == null) return;
    value = widget.menu!.value;
    content = widget.menu!.matchContent;
    number = widget.menu!.number;
    front = widget.menu!.front;
    behind = widget.menu!.behind;
    start = widget.menu!.start;
    end = widget.menu!.end;
    deleteTypes = widget.menu!.deleteTypes;
    deleteExtension = widget.menu!.deleteExtension;
    useRegex = widget.menu!.useRegex;
    group = widget.menu!.group;
  }

  @override
  Widget build(BuildContext context) {
    return EasyDialog(
      width: 500,
      title: tr(AppL10n.advanceDeleteTitle),
      content: Column(
        spacing: AppNum.spaceMedium,
        children: [
          ActionItem(
            padding: .zero,
            icon: AppIcons.regex,
            tip: tr(AppL10n.advanceRegex),
            checked: useRegex,
            onPressed: () => setState(() => useRegex = !useRegex),
            child: InputField(
              text: value,
              hintText: tr(AppL10n.advanceDeleteHint),
              onComplete: (value) => setState(() => this.value = value),
            ),
          ),
          // TODO: 匹配模式：内容、位置、类型、扩展
          // TODO: 匹配内容：第一个、最后一个、所有、第N个、前面N个、后面N个
          MatchContentGroup(
            content: content,
            onChanged: (value) => setState(() => content = value),
            number: number,
            onNumberChanged: (value) => setState(() => number = value),
            front: front,
            onFrontChanged: (value) => setState(() => front = value),
            behind: behind,
            onBehindChanged: (value) => setState(() => behind = value),
            start: start,
            end: end,
            onStartChanged: (value) => setState(() => start = value),
            onEndChanged: (value) => setState(() => end = value),
          ),
          DeleteTypeGroup(
            deleteTypes: deleteTypes,
            onChanged: (value) => setState(
              () => deleteTypes.contains(value)
                  ? deleteTypes.remove(value)
                  : deleteTypes.add(value),
            ),
          ),
          DeleteExtensionSwitch(
            value: deleteExtension,
            onChanged: (value) => setState(() => deleteExtension = value),
          ),
        ],
      ),
      extraButton: GroupDropdown(
        value: group == 'all' ? tr(AppL10n.dialogAll) : group,
        onChanged: (value) {
          group = isAll(value) ? 'all' : value;
          setState(() {});
        },
      ),
      onOk: () {
        String id = widget.menu?.id ?? generateId();
        AdvanceMenuDelete delete = AdvanceMenuDelete(
          id: id,
          value: value,
          matchContent: content,
          number: number,
          front: front,
          behind: behind,
          start: start,
          end: end,
          deleteTypes: deleteTypes,
          deleteExtension: deleteExtension,
          useRegex: useRegex,
          group: group,
          checked: true,
        );
        print(delete);
        widget.menu == null
            ? ref.read(advanceMenuListProvider.notifier).add(delete)
            : ref.read(advanceMenuListProvider.notifier).update(id, delete);
        ref.read(currentPresetNameProvider.notifier).update('');
        advanceUpdateName(ref);
      },
    );
  }
}
