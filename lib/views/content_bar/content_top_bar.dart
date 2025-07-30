import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/list.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/views/content_bar/expand_btn.dart';
import 'package:once_power/views/content_bar/view_mode_top_bar.dart';
import 'package:once_power/widgets/common/easy_checkbox.dart';
import 'package:once_power/widgets/common/one_line_text.dart';

import 'filter_btn.dart';
import 'hide_btn.dart';
import 'remove_btn.dart';
import 'sort_btn.dart';

class ContentTopBar extends ConsumerWidget {
  const ContentTopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isViewMode = ref.watch(isViewModeProvider);
    bool isOrganize = ref.watch(currentModeProvider).isOrganize;

    return Container(
      height: 40,
      // padding: const EdgeInsets.only(left: 4, right: AppNum.defaultP),
      alignment: Alignment.centerLeft,
      child: Builder(builder: (context) {
        if (isViewMode && !isOrganize) return ViewModeTopBar();

        String label = ref.watch(currentModeProvider).isOrganize ||
                ref.watch(isViewModeProvider)
            ? S.of(context).fileName
            : S.of(context).originalName;
        int selected = ref.watch(selectFileProvider);
        int total = ref.watch(fileListProvider).length;
        String label2 = ref.watch(currentModeProvider).isOrganize
            ? S.of(context).folder
            : S.of(context).renameName;

        return Row(
          children: [
            EasyCheckbox(
              label: '',
              checked: ref.watch(selectAllProvider),
              onChanged: (value) => selectAll(ref),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  OneLineText('$label ($selected/$total)'),
                  ExpandBtn(),
                  HideBtn(),
                  SizedBox(width: AppNum.smallG),
                ],
              ),
            ),
            // ContentTopLeft(),
            Expanded(
              flex: ref.watch(expandNewNameProvider) ? 2 : 1,
              child: Row(children: [OneLineText(label2), SortBtn()]),
            ),
            FilterBtn(),
            SizedBox(width: AppNum.smallG),
            RemoveBtn(onTap: () => removeAll(ref)),
            SizedBox(width: 12),
          ],
        );
      }),
    );
  }
}
