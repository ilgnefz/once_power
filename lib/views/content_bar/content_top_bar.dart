import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/cores/list.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/views/content_bar/adjust_image.dart';
import 'package:once_power/views/content_bar/count_checkbox.dart';
import 'package:once_power/views/content_bar/filter_btn.dart';
import 'package:once_power/views/content_bar/remove_btn.dart';
import 'package:once_power/views/content_bar/sort_btn.dart';

class ContentTopBar extends ConsumerWidget {
  const ContentTopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isViewMode = ref.watch(isViewModeProvider);
    bool isOrganize = ref.watch(currentModeProvider).isOrganize;
    return Container(
      height: 40,
      padding: const EdgeInsets.only(left: 4, right: AppNum.defaultP),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Expanded(child: CountCheckbox()),
          if (isViewMode && !isOrganize) AdjustImage(),
          SizedBox(width: AppNum.largeG),
          SortBtn(),
          SizedBox(width: AppNum.smallG),
          Builder(
            builder: (context) {
              if (isViewMode && !isOrganize) return SizedBox.shrink();
              String label =
                  isOrganize ? S.of(context).folder : S.of(context).renameName;
              return Expanded(child: Text(label));
            },
          ),
          Container(
            width: AppNum.extensionW,
            alignment: Alignment.center,
            child: FilterBtn(),
          ),
          RemoveBtn(onTap: () => removeAll(ref)),
        ],
      ),
    );
  }
}
