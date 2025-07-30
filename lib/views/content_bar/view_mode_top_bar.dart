import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/list.dart';
import 'package:once_power/views/content_bar/filter_btn.dart';

import 'adjust_image.dart';
import 'count_checkbox.dart';
import 'hide_btn.dart';
import 'remove_btn.dart';
import 'sort_btn.dart';

class ViewModeTopBar extends ConsumerWidget {
  const ViewModeTopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        CountCheckbox(),
        Spacer(),
        AdjustImage(),
        HideBtn(),
        SortBtn(),
        FilterBtn(),
        RemoveBtn(onTap: () => removeAll(ref)),
      ],
    );
  }
}
