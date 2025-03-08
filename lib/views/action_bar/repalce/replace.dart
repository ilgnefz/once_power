import 'package:flutter/material.dart';
import 'package:once_power/views/action_bar/rename/rename.dart';
import 'package:once_power/views/action_bar/repalce/select_replace_type.dart';

class ReplaceMenu extends StatelessWidget {
  const ReplaceMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return RenameMenu(child: SelectReplaceType());
  }
}
