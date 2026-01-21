import 'package:flutter/material.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/view/action/base.dart';

class ActionView extends StatelessWidget {
  const ActionView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: AppNum.actionWidth, child: BaseView());
  }
}
