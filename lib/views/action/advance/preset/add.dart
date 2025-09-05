import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/widgets/action/text_btn.dart';
import 'package:tolyui_feedback/toly_popover/toly_popover.dart';

class AddPreset extends StatelessWidget {
  const AddPreset({super.key, required this.controller});

  final PopoverController controller;

  @override
  Widget build(BuildContext context) {
    return EasyTextBtn(
      tr(AppL10n.advanceAddPreset),
      onTap: () {
        controller.close();
        // final current = ref.read(advanceMenuListProvider);
        // final copies = current.map((e) => e.copyWith()).toList();
        // addPreset(context, ref, copies);
      },
    );
  }
}
