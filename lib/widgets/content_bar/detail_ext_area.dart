import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/widgets/common/easy_checkbox.dart';

class DetailExtArea extends ConsumerWidget {
  const DetailExtArea({
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
    Color dividerColor = Theme.of(context).primaryColor.withOpacity(.2);

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
          children: extList.map((v) {
            return EasyCheckbox(
              v,
              checked: ref.watch(selectedExtensionProvider(v)),
              mainAxisSize: MainAxisSize.min,
              onChanged: (b) =>
                  ref.read(fileListProvider.notifier).checkExtension(v),
            );
          }).toList(),
        ),
      ],
    );
  }
}
