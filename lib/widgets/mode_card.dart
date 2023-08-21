import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/toggle.dart';

class ModeCard extends ConsumerWidget {
  const ModeCard({super.key, required this.label, required this.mode});

  final String label;
  final FunctionMode mode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(currentModeProvider) == mode;

    return Flexible(
      flex: 1,
      child: InkWell(
        onTap: () => ref.read(currentModeProvider.notifier).update(mode),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          // width: AppNum.modeCardW,
          margin: const EdgeInsets.symmetric(horizontal: AppNum.modeCardP * 2),
          decoration: BoxDecoration(
            border: selected
                ? const Border(
                    bottom: BorderSide(color: AppColors.select, width: 4),
                  )
                : const Border(),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: selected
                ? const TextStyle(
                    color: AppColors.select,
                    fontWeight: FontWeight.bold,
                  )
                : const TextStyle(color: AppColors.unselectText),
          ),
        ),
      ),
    );
  }
}
