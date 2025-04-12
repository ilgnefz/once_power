import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/widgets/common/easy_text_dropdown.dart';

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
    bool isAll = widget.value == S.current.all;
    groups.add(S.current.all);
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
    return Row(
      children: [
        Text(
          '${S.of(context).applyGroup}:',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        EasyTextDropdown(
          items: groups
              .map((item) => DropdownMenuItem(
                    key: ValueKey(item),
                    value: item,
                    alignment: Alignment.center,
                    child: Text(item, overflow: TextOverflow.ellipsis),
                  ))
              .toList(),
          value: widget.value,
          width: 120,
          isExpanded: true,
          maxHeight: AppNum.dropdownMenuH * 12,
          offset: Offset(0, AppNum.dropdownMenuH * num),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
