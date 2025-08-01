import 'package:flutter/material.dart';
import 'package:once_power/views/action_bar/date_property/apply_date_btn.dart';
import 'package:once_power/views/action_bar/date_property/date_input_group.dart';
import 'package:once_power/views/action_bar/rename/add_folder_checkbox.dart';
import 'package:once_power/views/action_bar/rename/append_checkbox.dart';
import 'package:once_power/widgets/action_bar/add_file_group.dart';
import 'package:once_power/widgets/action_bar/two_checkbox_group.dart';

import 'date_property_top_bar.dart';

class DatePropertyView extends StatelessWidget {
  const DatePropertyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DatePropertyTopBar(),
        DateInputGroup(),
        TwoCheckboxGroup(children: [AddFolderCheckbox(), AppendCheckbox()]),
        AddFolderGroup(child: ApplyDateBtn()),
      ],
    );
  }
}
