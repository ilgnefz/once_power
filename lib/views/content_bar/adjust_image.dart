import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/providers/value.dart';
import 'package:once_power/widgets/common/click_icon.dart';

class AdjustImage extends ConsumerWidget {
  const AdjustImage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClickIcon(
      svg: AppIcons.imageSize,
      size: 32,
      color: Theme.of(context).iconTheme.color,
      onTap: () => ref.read(viewImageWidthProvider.notifier).update(true),
      onSecondaryTap: () =>
          ref.read(viewImageWidthProvider.notifier).update(false),
      onLongPress: () => showImageSize(context),
    );
  }
}
