import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/core/rename.dart';
import 'package:once_power/provider/file.dart';

class PathClassifyList extends ConsumerWidget {
  const PathClassifyList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> pathList = ref.watch(pathListProvider);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: pathList.length,
      itemBuilder: (context, index) {
        String folder = pathList[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: ref.watch(selectedPathProvider(folder)),
              onChanged: (v) {
                ref.read(fileListProvider.notifier).checkFolder(folder);
                updateName(ref);
                updateExtension(ref);
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: SelectableText(
                  folder,
                  maxLines: null,
                  style: TextStyle().useSystemChineseFont(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
