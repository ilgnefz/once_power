import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/utils/rename.dart';

class ModeCard extends ConsumerWidget {
  const ModeCard({super.key, required this.label, required this.mode});

  final String label;
  final FunctionMode mode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(currentModeProvider) == mode;

    void toggleMode() {
      FunctionMode before = ref.watch(currentModeProvider);
      if (before == mode) return;
      if (mode == FunctionMode.reserve) {
        bool matchNotEmpty = ref.watch(matchClearProvider);
        bool modifyNotEmpty = ref.watch(modifyClearProvider);
        if (matchNotEmpty && modifyNotEmpty) {
          ref.watch(modifyControllerProvider).text = '';
        }
        if (matchNotEmpty && ref.watch(dateRenameProvider)) {
          ref.watch(matchControllerProvider).text = '';
        }
      }
      ref.read(currentModeProvider.notifier).update(mode);
      updateName(ref);
    }

    return Flexible(
      flex: 1,
      child: InkWell(
        onTap: toggleMode,
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
