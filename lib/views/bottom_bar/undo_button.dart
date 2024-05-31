import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/core/rename.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/widgets/small_text_button.dart';

class UndoButton extends ConsumerWidget {
  const UndoButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String undoLabel = S.of(context).undo;

    return SmallTextButton(
      text: undoLabel,
      margin: 0,
      onTap: () => undo(ref),
    );
  }
}
