import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/icon.dart';
import 'package:once_power/constant/key.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/service/storage.dart';
import 'package:once_power/widget/bottom/icon.dart';

class SaveButton extends StatefulWidget {
  const SaveButton({super.key});

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  bool save = false;

  @override
  void initState() {
    super.initState();
    save = StorageService.getBoolDefault(AppKeys.save);
  }

  @override
  Widget build(BuildContext context) {
    return BottomClickIcon(
      tip: context.tr(AppL10n.save),
      svg: AppIcons.save,
      selected: save,
      onPressed: () async {
        setState(() => save = !save);
        unawaited(StorageService.setBool(AppKeys.save, save));
      },
    );
  }
}
