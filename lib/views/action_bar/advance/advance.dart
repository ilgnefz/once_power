import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/core/advance.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/views/action_bar/rename/tool_menu/additional_options.dart';
import 'package:once_power/views/action_bar/rename/tool_menu/apply_menu.dart';
import 'package:once_power/widgets/common/easy_text_btn.dart';

import 'advance_list.dart';
import 'preset_btn.dart';

class AdvanceAction extends ConsumerWidget {
  const AdvanceAction({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: AppNum.mediumG,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppNum.mediumG),
            child: AdvanceList(),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: AppNum.defaultP,
            right: AppNum.defaultP,
            bottom: AppNum.defaultP,
            top: AppNum.smallG,
          ),
          child: Column(
            spacing: AppNum.mediumG,
            children: [
              Row(
                spacing: AppNum.smallG,
                children: [
                  EasyTextBtn(S.of(context).delete,
                      onTap: () => deleteText(context, ref)),
                  EasyTextBtn(S.of(context).add,
                      onTap: () => addText(context, ref)),
                  EasyTextBtn(S.of(context).replace,
                      onTap: () => replaceText(context, ref)),
                  Spacer(),
                  PresetBtn(),
                ],
              ),
              AdditionalOptions(show: false),
              ApplyMenu(),
            ],
          ),
        ),
      ],
    );
  }
}
