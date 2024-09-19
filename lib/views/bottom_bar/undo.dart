import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/core/rename.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/widgets/common/text_btn.dart';

class UndoBtn extends ConsumerWidget {
  const UndoBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String label = S.of(context).undo;

    return TextBtn(
      text: label,
      margin: 0,
      onTap: () => undo(ref),
    );
  }
}
