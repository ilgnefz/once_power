import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/widgets/base/easy_checkbox.dart';

class ExtensionArea extends ConsumerWidget {
  const ExtensionArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final extensionMap = ref.watch(
      extensionListMapProvider.select((value) => value),
    );

    return SingleChildScrollView(
      padding: EdgeInsets.only(right: AppNum.padding),
      child: Column(
        children: extensionMap.entries.map((entry) {
          return Column(
            children: [
              TypeGroupHeader(label: entry.key.label),
              const SizedBox(height: AppNum.spaceSmall),
              _buildExtensionCheckboxes(ref, entry.value),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildExtensionCheckboxes(WidgetRef ref, List<String> extensions) {
    return Wrap(
      spacing: AppNum.spaceLarge,
      runSpacing: AppNum.spaceMedium,
      children: extensions.map((extension) {
        return EasyCheckbox(
          label: extension,
          checked: ref.watch(selectedExtensionProvider(extension)),
          onChanged: (v) {
            ref.read(fileListProvider.notifier).checkExtension(extension);
            updateName(ref);
          },
        );
      }).toList(),
    );
  }
}

class TypeGroupHeader extends ConsumerWidget {
  const TypeGroupHeader({required this.label, super.key});
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        const Divider(height: 1, color: Color(0xFFE1DCED)),
        ColoredBox(
          color: theme.scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(label, style: TextStyle(color: theme.primaryColor)),
          ),
        ),
      ],
    );
  }
}
