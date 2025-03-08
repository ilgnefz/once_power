import 'package:flutter/material.dart';
import 'package:once_power/views/action_bar/rename/rename.dart';
import 'package:once_power/views/action_bar/reserve/select_reserve_type.dart';

class ReserveMenu extends StatelessWidget {
  const ReserveMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return RenameMenu(child: SelectReserveType());
  }
}
