import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/widgets/action_bar/easy_btn.dart';

class DirectiveGroup extends ConsumerWidget {
  const DirectiveGroup({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppNum.defaultP,
        vertical: AppNum.smallG,
      ),
      child: Row(
        spacing: AppNum.smallG,
        children: [
          EasyBtn(S.of(context).delete, onTap: () => deleteText(context)),
          EasyBtn(S.of(context).add, onTap: () => addText(context)),
          EasyBtn(S.of(context).replace, onTap: () => replaceText(context)),
          Spacer(),
          child,
        ],
      ),
    );
  }
}
