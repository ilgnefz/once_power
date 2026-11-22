import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/widget/base/dropdown.dart';
import 'package:once_power/widget/base/text.dart';

class ButtonGroup extends StatelessWidget {
  const ButtonGroup({
    super.key,
    required this.group,
    required this.onComplete,
    required this.onCompleteExit,
    required this.onGroupChange,
  });

  final String group;
  final void Function() onComplete;
  final void Function() onCompleteExit;
  final void Function(String) onGroupChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppNumber.widgetHeight,
      padding: .symmetric(horizontal: AppNumber.padding),
      child: Row(
        spacing: AppNumber.spaceSmall,
        children: [
          BaseText('应用组:'),
          EasyTextDropdown<String>(
            value: group,
            items: [
              '0',
              '1',
              '2',
            ].map((e) => TextDropdownItem<String>(e, label: e)).toList(),
            onChanged: onGroupChange,
          ),
          const Spacer(),
          TextButton(onPressed: onComplete, child: Text('确认')),
          TextButton(onPressed: onCompleteExit, child: Text('确认并关闭')),
        ],
      ),
    );
  }
}
