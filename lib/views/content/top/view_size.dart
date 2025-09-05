import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/utils/format.dart';
import 'package:once_power/widgets/common/dialog.dart';
import 'package:once_power/widgets/common/dialog_input.dart';
import 'package:once_power/widgets/content/easy_click_text.dart';

class CustomViewSize extends ConsumerStatefulWidget {
  const CustomViewSize({super.key});

  @override
  ConsumerState<CustomViewSize> createState() => _CustomImageSizeState();
}

class _CustomImageSizeState extends ConsumerState<CustomViewSize> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    double width = ref.read(viewImageWidthProvider);
    controller = TextEditingController(text: formatDouble(width))
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

  void onOk() {
    double? value = double.tryParse(controller.text);
    if (value == null) return;
    ref.read(viewImageWidthProvider.notifier).set(value);
  }

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: tr(AppL10n.dialogImage),
      onCancel: () {},
      onOk: onOk,
      child: Column(
        spacing: AppNum.spaceMedium,
        children: [
          DialogBaseInput(
            controller: controller,
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
              String label = formatDouble(e);
              return EasyClickText(label: label, onTap: () => setValue(label));
            }).toList(),
          ),
        ],
      ),
    );
  }
}
