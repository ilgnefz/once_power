import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/core/organize.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/input.dart';

class OrganizeButton extends ConsumerWidget {
  const OrganizeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(Size.fromWidth(
          MediaQuery.of(context).size.width,
        )),
      ),
      onPressed:
          ref.watch(fileListProvider).isEmpty || !ref.watch(targetClearProvider)
              ? null
              : () => organizeFolder(context, ref),
      child: Text(S.of(context).organizeMenu),
    );
  }
}
