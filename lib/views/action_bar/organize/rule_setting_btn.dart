import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/rule_type.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/views/action_bar/advance/dialog/common_dialog.dart';
import 'package:once_power/views/action_bar/organize/rule_list.dart';
import 'package:once_power/widgets/action_bar/easy_btn.dart';
import 'package:once_power/widgets/action_bar/folder_input.dart';

import '../../../models/file_enum.dart';
import 'rule_card.dart';

class RuleSettingBtn extends ConsumerWidget {
  const RuleSettingBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void showAllRule() {
      showDialog(context: context, builder: (context) => RuleList());
    }

    return EasyBtn(
      S.of(context).classifyType,
      height: 30,
      onTap: showAllRule,
    );

    // return Ink(
    //   decoration: BoxDecoration(borderRadius: borderRadius),
    //   child: InkWell(
    //     borderRadius: borderRadius,
    //     onTap: showAllRule,
    //     child: Container(
    //       height: AppNum.inputH,
    //       padding: EdgeInsets.symmetric(horizontal: AppNum.mediumG),
    //       decoration: BoxDecoration(
    //         borderRadius: borderRadius,
    //       ),
    //       alignment: Alignment.center,
    //       child: Text(
    //         S.of(context).classifyType,
    //         style: TextStyle(
    //           fontSize: 14,
    //           color: Theme.of(context).primaryColor.withValues(alpha: .8),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

class EasyChild extends StatelessWidget {
  const EasyChild({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppNum.inputP, vertical: AppNum.smallG),
      child: Row(
        // spacing: AppNum.smallG,
        children: [
          Text('$title:'),
          Expanded(child: FolderInput()),
        ],
      ),
    );
  }
}
