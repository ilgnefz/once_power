import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/model/rename_file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/widgets/check_tile.dart';
import 'package:once_power/widgets/easy_tooltip.dart';
import 'package:once_power/widgets/normal_tile.dart';

class ContentFileTitle extends HookConsumerWidget {
  const ContentFileTitle({super.key, required this.file});

  final RenameFile file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double fontSize = 12;

    final hover = useState(false);

    void delete() {
      ref.read(fileListProvider.notifier).remove(file.id);
      ref.read(totalProvider.notifier).reduce();
    }

    return EasyTooltip(
      message: file.name,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (_) => hover.value = true,
        onExit: (_) => hover.value = false,
        child: ColoredBox(
          // duration: const Duration(milliseconds: 200),
          color: hover.value
              ? Theme.of(context).colorScheme.background
              : Colors.white,
          child: Row(
            children: [
              CheckTile(
                check: file.checked,
                label: file.name,
                fontSize: fontSize,
                onChanged: (v) =>
                    ref.read(fileListProvider.notifier).check(file.id),
                color: Colors.grey,
              ),
              NormalTile(label: file.newName, fontSize: fontSize),
              SizedBox(
                width: AppNum.extensionW,
                child: Center(
                  child: Text(
                    file.extension,
                    style: const TextStyle(fontSize: fontSize),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(
                width: AppNum.deleteW,
                child: Center(
                  child: IconButton(
                    onPressed: delete,
                    color: Colors.black26,
                    icon: const Icon(Icons.delete_forever_rounded),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
