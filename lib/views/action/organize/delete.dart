import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/views/action/organize/delete_empty.dart';
import 'package:once_power/views/action/organize/delete_selected.dart';

class DeleteGroup extends StatelessWidget {
  const DeleteGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppNum.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [DeleteSelectedBtn(), DeleteEmptyBtn()],
      ),
    );
  }
}
