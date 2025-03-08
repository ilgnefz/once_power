import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';

class ViewStructure extends StatelessWidget {
  const ViewStructure({
    super.key,
    required this.operateList,
    required this.bottomAction,
  });

  final List<Widget> operateList;
  final List<Widget> bottomAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppNum.mediumG),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(spacing: AppNum.mediumG, children: operateList),
            ),
          ),
          ...bottomAction
        ],
      ),
    );
  }
}
