import 'package:flutter/material.dart';
import 'package:once_power/views/action_bar/rename/rename.dart';
import 'package:once_power/views/action_bar/reserve/select_reserve_type.dart';

class ReserveMenu extends StatefulWidget {
  const ReserveMenu({super.key});

  @override
  State<ReserveMenu> createState() => _ReserveMenuState();
}

class _ReserveMenuState extends State<ReserveMenu>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RenameMenu(child: SelectReserveType());
  }

  @override
  bool get wantKeepAlive => true;
}
