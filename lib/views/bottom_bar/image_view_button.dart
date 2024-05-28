import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/widgets/click_icon.dart';
import 'package:once_power/widgets/custom_tooltip.dart';

class ImageViewButton extends ConsumerWidget {
  const ImageViewButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String imageViewMode = S.of(context).imageViewMode;

    bool imageView = ref.watch(imageViewProvider);

    return CustomTooltip(
      content: Text(
        imageViewMode,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      child: ClickIcon(
        size: 24,
        svg: AppIcons.image,
        color: imageView ? Theme.of(context).primaryColor : Colors.grey,
        onTap: ref.read(imageViewProvider.notifier).update,
      ),
    );
  }
}
