import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/core/organize.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';

class OrganizeButton extends ConsumerWidget {
  const OrganizeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: ref.watch(fileListProvider).isNotEmpty &&
              (ref.watch(targetClearProvider) ||
                  ref.watch(useTopFolderProvider))
          ? () => organizeFolder(context, ref)
          : null,
      child: Text(S.of(context).organizeBtn),
    );
  }
}
