import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/rename.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/providers/list.dart';
import 'package:once_power/widgets/common/easy_checkbox.dart';

import '../../cores/update_name.dart';

class DetailExtensionArea extends ConsumerWidget {
  const DetailExtensionArea({
    super.key,
    required this.label,
    required this.extList,
    this.onChanged,
  });

  final String label;
  final List<String> extList;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color dividerColor = Theme.of(context).primaryColor.withValues(alpha: .2);

    TextStyle subtitleStyle = TextStyle(
      color: Theme.of(context).primaryColor,
    ).useSystemChineseFont();

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Divider(height: 1, color: dividerColor),
            ColoredBox(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  label,
                  style: subtitleStyle,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppNum.smallG),
        Wrap(
          spacing: AppNum.largeG,
          runSpacing: AppNum.mediumG,
          children: extList.map((e) {
            return EasyCheckbox(
              label: e,
              checked: ref.watch(selectedExtensionProvider(e)),
              mainAxisSize: MainAxisSize.min,
              onChanged: (value) {
                ref.read(fileListProvider.notifier).checkExtension(e);
                updateName(ref);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
