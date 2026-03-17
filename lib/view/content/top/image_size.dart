import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/widget/base/dialog.dart';
import 'package:once_power/widget/common/click_text.dart';
import 'package:once_power/widget/common/input_field.dart';

class ImageSizeView extends ConsumerStatefulWidget {
  const ImageSizeView({super.key});

  @override
  ConsumerState<ImageSizeView> createState() => _CustomImageSizeState();
}

class _CustomImageSizeState extends ConsumerState<ImageSizeView> {
  int? width;

  @override
  void initState() {
    super.initState();
    width = ref.read(viewImageWidthProvider);
  }

  @override
  Widget build(BuildContext context) {
    return EasyDialog(
      title: tr(AppL10n.dialogImage),
      onCancel: () {},
      onOk: () {
        if (width == null) return;
        ref.read(viewImageWidthProvider.notifier).set(width!);
      },
      content: Column(
        spacing: AppNum.spaceMedium,
        children: [
          InputField(
            text: width?.toString() ?? '',
            hintText: tr(AppL10n.dialogImageHint),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,1}$')),
            ],
            onChanged: (v) {},
          ),
          Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: AppNum.spaceMedium,
            runSpacing: AppNum.spaceMedium,
            children: AppNum.imageSizes.map((e) {
              return EasyClickText(
                label: e.toString(),
                onPressed: () => setState(() => width = e),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
