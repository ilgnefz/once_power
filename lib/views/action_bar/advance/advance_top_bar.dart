import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/advance.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/providers/advance.dart';
import 'package:once_power/widgets/common/click_icon.dart';

class AdvanceTopBar extends StatelessWidget {
  const AdvanceTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      alignment: Alignment.centerLeft,
      padding:
          EdgeInsets.only(left: AppNum.detailDialogP, right: AppNum.largeG),
      child: Consumer(
        builder: (context, ref, child) {
          List<AdvanceMenuModel> list = ref.watch(advanceMenuListProvider);
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.totalInstructions(list.length),
                style: TextStyle(fontSize: 13, color: Colors.grey)
                    .useSystemChineseFont(),
              ),
              ClickIcon(
                size: 20,
                iconSize: 16,
                icon: Icons.delete_outline_rounded,
                color: Colors.grey,
                onTap: () {
                  ref.read(advanceMenuListProvider.notifier).setList([]);
                  advanceUpdateName(ref);
                },
              )
            ],
          );
        },
      ),
    );
  }
}
