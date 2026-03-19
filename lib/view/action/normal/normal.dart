import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/update/normal.dart';
import 'package:once_power/core/upload.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/view/action/add.dart';
import 'package:once_power/view/action/apply.dart';
import 'package:once_power/view/action/normal/affix.dart';
import 'package:once_power/view/action/normal/case.dart';
import 'package:once_power/view/action/normal/date.dart';
import 'package:once_power/view/action/normal/extension.dart';
import 'package:once_power/view/action/normal/modify.dart';
import 'package:once_power/view/action/normal/index.dart';
import 'package:once_power/view/action/picker.dart';
import 'package:once_power/widget/action/struct.dart';

import 'chip.dart';
import 'match.dart';

class NormalView extends StatefulWidget {
  const NormalView(this.isReplace, {super.key});

  final bool isReplace;

  @override
  State<NormalView> createState() => _NormalViewState();
}

class _NormalViewState extends State<NormalView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ActionStruct(
      menus: [
        MatchInput(),
        MatchChip(widget.isReplace),
        ModifyInput(),
        DateInput(),
        AffixInput(
          label: tr(AppL10n.renamePrefix),
          hintText: tr(AppL10n.renamePrefixHint),
          tip: tr(AppL10n.renamePrefixCircle),
          controllerProvider: prefixControllerProvider,
          cycleProvider: isCyclePrefixProvider,
          info: prefixUploadMarkProvider,
          onUpload: (ref, value) async {
            UploadMarkInfo? info = await uploadTextFile(value);
            if (info != null) {
              ref.read(prefixUploadMarkProvider.notifier).update(info);
              normalUpdateName(ref);
            }
          },
        ),
        IndexInput(
          label: tr(AppL10n.renameIndex),
          tip: tr(AppL10n.renamePrefixSwap),
          swapProvider: isSwapPrefixProvider,
          digitProvider: prefixWidthProvider,
          startProvider: prefixStartProvider,
        ),
        AffixInput(
          label: tr(AppL10n.renameSuffix),
          hintText: tr(AppL10n.renameSuffixHint),
          tip: tr(AppL10n.renameSuffixCircle),
          controllerProvider: suffixControllerProvider,
          cycleProvider: isCycleSuffixProvider,
          info: suffixUploadMarkProvider,
          onUpload: (ref, value) async {
            UploadMarkInfo? info = await uploadTextFile(value);
            if (info != null) {
              info.copyWith(isPrefix: false);
              ref.read(suffixUploadMarkProvider.notifier).update(info);
              normalUpdateName(ref);
            }
          },
        ),
        IndexInput(
          label: tr(AppL10n.renameIndex),
          tip: tr(AppL10n.renameSuffixSwap),
          swapProvider: isSwapSuffixProvider,
          digitProvider: suffixWidthProvider,
          startProvider: suffixStartProvider,
        ),
        ExtensionInput(),
      ],
      actions: [
        CaseGroup(),
        AddGroup(),
        SizedBox(height: AppNum.spaceMedium),
        FilePickerGroup(slot: ApplyButton()),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
