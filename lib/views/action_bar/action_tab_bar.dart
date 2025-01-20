import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/widgets/action_bar/function_mode_tab.dart';

class ActionTabBar extends ConsumerWidget {
  const ActionTabBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: AppNum.actionBarW,
      height: AppNum.modeCardH,
      padding: EdgeInsets.symmetric(horizontal: AppNum.defaultP),
      color: Colors.white,
      child: Row(
        spacing: ref.watch(extraFunctionProvider)
            ? AppNum.modeCardG
            : AppNum.modeCardG / 2,
        children: [
          FunctionModeTab(
            label: S.of(context).replace,
            mode: FunctionMode.replace,
          ),
          FunctionModeTab(
              label: S.of(context).reserve, mode: FunctionMode.reserve),
          if (ref.watch(extraFunctionProvider))
            FunctionModeTab(
              label: S.of(context).advance,
              mode: FunctionMode.advance,
            ),
          FunctionModeTab(
            label: S.of(context).organize,
            mode: FunctionMode.organize,
          ),
        ],
      ),
    );
  }
}
