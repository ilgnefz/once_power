import 'package:flutter/material.dart';
import 'package:once_power/views/action_bar/rename/rename.dart';
import 'package:once_power/views/action_bar/repalce/select_replace_type.dart';

class ReplaceMenu extends StatefulWidget {
  const ReplaceMenu({super.key});

  @override
  State<ReplaceMenu> createState() => _ReplaceMenuState();
}

class _ReplaceMenuState extends State<ReplaceMenu>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RenameMenu(child: SelectReplaceType());
  }

  @override
  bool get wantKeepAlive => true;
}
