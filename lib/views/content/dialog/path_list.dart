import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/notification.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/widgets/base/easy_checkbox.dart';
import 'package:once_power/widgets/common/click_icon.dart';

class PathList extends ConsumerWidget {
  const PathList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> pathList = ref.watch(
      pathListProvider.select((value) => value),
    );

    return ListView.separated(
      shrinkWrap: true,
      itemCount: pathList.length,
      padding: EdgeInsets.only(right: AppNum.padding),
      itemBuilder: (context, index) {
        final String folder = pathList[index];
        return PathItem(folder: folder);
      },
      separatorBuilder: (_, __) => const SizedBox(height: AppNum.spaceSmall),
    );
  }
}

class PathItem extends ConsumerWidget {
  const PathItem({required this.folder, super.key});
  final String folder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isSelected = ref.watch(selectedPathProvider(folder));

    return EasyCheckbox(
      checked: isSelected,
      onChanged: (v) => {
        ref.read(fileListProvider.notifier).checkFolder(folder),
        updateName(ref),
      },
      child: Expanded(
        child: RichText(
          text: TextSpan(
            text: folder,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
              fontSize: 14,
              height: 1.5,
            ),
            children: [
              const WidgetSpan(child: SizedBox(width: AppNum.spaceSmall)),
              WidgetSpan(
                child: ClickIcon(
                  icon: Icons.file_copy_rounded,
                  size: 18,
                  iconSize: 16,
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: folder));
                    showCopyNotification(folder);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
