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
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    int width = ref.read(viewImageWidthProvider);
    controller = TextEditingController(text: width.toString())
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void setValue(String value) {
    controller.text = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return EasyDialog(
      title: tr(AppL10n.dialogImage),
      padding: .zero,
      content: Column(
        spacing: AppNum.spaceMedium,
        mainAxisSize: .min,
        children: [
          InputField(
            controller: controller,
            margin: .symmetric(horizontal: AppNum.padding),
            hintText: tr(AppL10n.dialogImageHint),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,1}$')),
            ],
          ),
          Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: AppNum.spaceMedium,
            runSpacing: AppNum.spaceMedium,
            children: AppNum.imageSizes.map((e) {
              String label = e.toString();
              return EasyClickText(
                label: label,
                radius: AppNum.radiusSmall,
                onPressed: () => setValue(label),
              );
            }).toList(),
          ),
        ],
      ),
      onCancel: () {},
      onOk: () {
        int? value = int.tryParse(controller.text);
        if (value == null) return;
        ref.read(viewImageWidthProvider.notifier).set(value);
      },
    );
  }
}
