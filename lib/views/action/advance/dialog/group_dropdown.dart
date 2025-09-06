import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/widgets/common/dropdown_text.dart';

class GroupDropdown extends ConsumerStatefulWidget {
  const GroupDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final String value;
  final void Function(String?)? onChanged;

  @override
  ConsumerState<GroupDropdown> createState() => _GroupDropdownState();
}

class _GroupDropdownState extends ConsumerState<GroupDropdown> {
  List<String> groups = [];
  int num = 0;

  @override
  void initState() {
    super.initState();
    List<String> list = StorageUtil.getStringList(AppKeys.groupList);
    bool isAll = widget.value == tr(AppL10n.dialogAll);
    groups.add(tr(AppL10n.dialogAll));
    if (!isAll && !list.contains(widget.value)) groups.add(widget.value);
    groups.addAll(list);
    if (groups.length > 2 && groups.length <= 10) {
      num = groups.length - 2;
    } else if (groups.length > 10) {
      num = 10;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      spacing: AppNum.spaceSmall,
      children: [
        Text(
          '${tr(AppL10n.dialogApplyGroup)}:',
          style: TextStyle(color: theme.primaryColor),
        ),
        TextDropdown(
          items: groups
              .map(
                (item) => DropdownMenuItem(
                  key: ValueKey(item),
                  value: item,
                  alignment: Alignment.center,
                  child: Text(
                    item,
                    overflow: TextOverflow.ellipsis,
                    style: theme.dropdownMenuTheme.textStyle,
                  ),
                ),
              )
              .toList(),
          value: widget.value,
          width: 120,
          isExpanded: true,
          maxHeight: AppNum.dropdownMenu * 12,
          offset: Offset(0, AppNum.dropdownMenu * num),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
