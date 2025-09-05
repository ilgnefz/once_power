import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/widgets/common/tooltip_icon.dart';

class CSVBtn extends ConsumerWidget {
  const CSVBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TooltipIcon(
      tip: tr(AppL10n.bottomCSV),
      svg: AppIcons.csv,
      onTap: () {},
    );
  }
}
