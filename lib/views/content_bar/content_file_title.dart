import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:once_power/constants/colors.dart';
import 'package:once_power/model/rename_file.dart';
import 'package:once_power/widgets/check_tile.dart';
import 'package:once_power/widgets/normal_tile.dart';

class ContentFileTitle extends HookWidget {
  const ContentFileTitle({super.key, required this.file});

  final RenameFile file;

  @override
  Widget build(BuildContext context) {
    final hover = useState(false);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (_) => hover.value = true,
      onExit: (_) => hover.value = false,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        color: hover.value
            ? Theme.of(context).colorScheme.background
            : Colors.white,
        child: Row(
          children: [
            CheckTile(file.name),
            NormalTile(file.newName),
            SizedBox(
              width: 64,
              child: Center(child: Text(file.extension)),
            ),
            SizedBox(
              width: 48,
              child: Center(
                child: IconButton(
                  onPressed: () {},
                  color: AppColors.icon,
                  icon: const Icon(Icons.delete_forever_rounded),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
