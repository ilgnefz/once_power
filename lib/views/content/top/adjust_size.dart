import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/widgets/common/tooltip_icon.dart';

class AdjustSize extends ConsumerWidget {
  const AdjustSize({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TooltipIcon(
      tip: tr(AppL10n.contentAdjustSize),
      svg: AppIcons.imageSize,
      size: 32,
      color: Theme.of(context).iconTheme.color,
      onPressed: () => ref.read(viewImageWidthProvider.notifier).update(true),
      onSecondaryTap: () =>
          ref.read(viewImageWidthProvider.notifier).update(false),
      onLongPress: () => showImageSize(context),
    );
  }
}
