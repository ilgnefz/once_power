import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/match.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/widget/action/marquee_chip.dart';

class MatchChip extends ConsumerWidget {
  const MatchChip(this.isReplace, {super.key});

  final bool isReplace;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: .symmetric(horizontal: AppNumber.padding),
      child: isReplace
          ? MarqueeChipRow<ReplaceType>(
              items: ReplaceType.values,
              labelOf: (ReplaceType value) => value.label,
              selected: ref.watch(selectedReplaceTypeProvider),
              spacing: AppNumber.spaceSmall,
              speed: 64,
              onTap: ref.read(selectedReplaceTypeProvider.notifier).update,
            )
          : MarqueeChipRow<KeepType>(
              items: KeepType.values,
              labelOf: (KeepType value) => value.label,
              selected: ref.watch(selectedKeepTypeProvider),
              spacing: AppNumber.spaceSmall,
              onTap: ref.read(selectedKeepTypeProvider.notifier).update,
            ),
    );
  }
}
