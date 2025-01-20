import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';

class FunctionModeTab extends ConsumerWidget {
  const FunctionModeTab({super.key, required this.label, required this.mode});

  final String label;
  final FunctionMode mode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(currentModeProvider) == mode;
    Border? border = selected
        ? const Border(bottom: BorderSide(color: AppColors.primary, width: 4))
        : null;
    TextStyle style = selected
        ? const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)
        : const TextStyle(color: AppColors.unselectText);

    void toggleMode() {
      FunctionMode before = ref.watch(currentModeProvider);
      if (before == mode) return;
      if (mode.isReserve) {
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
      if (!mode.isOrganize && ref.watch(viewModeProvider)) {
        filterFile(context, ref);
      }
      updateName(ref);
    }

    return Flexible(
      flex: 1,
      child: InkWell(
        onTap: toggleMode,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          // margin: EdgeInsets.symmetric(
          //   horizontal: AppNum.modeCardM
          // ),
          decoration: BoxDecoration(border: border),
          alignment: Alignment.center,
          child: Text(label, style: style),
        ),
      ),
    );
  }
}
