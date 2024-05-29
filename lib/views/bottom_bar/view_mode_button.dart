import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/widgets/click_icon.dart';
import 'package:once_power/widgets/custom_tooltip.dart';
import 'package:tolyui_feedback/toly_tooltip/tooltip_placement.dart';

class ViewModeButton extends ConsumerWidget {
  const ViewModeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String viewMode = S.of(context).viewMode;

    bool isViewMode = ref.watch(viewModeProvider);

    void toggleView() {
      if (!isViewMode) {
        ref
            .read(fileListProvider.notifier)
            .removeOtherClassify(FileClassify.image);
      }
      ref.read(viewModeProvider.notifier).update();
    }

    return CustomTooltip(
      message: viewMode,
      textStyle: const TextStyle(fontSize: 13, color: Color(0xFF666666))
          .useSystemChineseFont(),
      placement: Placement.top,
      child: ClickIcon(
        size: 24,
        svg: AppIcons.image,
        color: isViewMode ? Theme.of(context).primaryColor : Colors.grey,
        onTap: toggleView,
      ),
    );
  }
}
