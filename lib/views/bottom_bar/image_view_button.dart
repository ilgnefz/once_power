import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/widgets/click_icon.dart';
import 'package:once_power/widgets/custom_tooltip.dart';
import 'package:tolyui_feedback/toly_tooltip/tooltip_placement.dart';

class ImageViewButton extends ConsumerWidget {
  const ImageViewButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String imageViewMode = S.of(context).imageViewMode;

    bool imageView = ref.watch(imageViewProvider);

    return CustomTooltip(
      message: imageViewMode,
      textStyle: const TextStyle(fontSize: 13, color: Color(0xFF666666))
          .useSystemChineseFont(),
      placement: Placement.top,
      child: ClickIcon(
        size: 24,
        svg: AppIcons.image,
        color: imageView ? Theme.of(context).primaryColor : Colors.grey,
        onTap: ref.read(imageViewProvider.notifier).update,
      ),
    );
  }
}
