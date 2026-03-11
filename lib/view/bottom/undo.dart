import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/rename.dart';
import 'package:once_power/enum/app.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widget/bottom/text.dart';

class UndoButton extends ConsumerWidget {
  const UndoButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!ref.watch(showUndoProvider) ||
        ref.watch(currentModeProvider).isOrganize) {
      return SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(left: AppNum.spaceSmall),
      child: BottomTextButton(
        tr(AppL10n.bottomUndo),
        onPressed: () => runRename(ref, true),
      ),
    );
  }
}
