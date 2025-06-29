import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/value.dart';
import 'package:once_power/utils/format.dart';
import 'package:once_power/views/action_bar/advance/dialog/common_dialog.dart';
import 'package:once_power/views/action_bar/advance/dialog/dialog_base_input.dart';
import 'package:once_power/widgets/content_bar/easy_click_text.dart';

class CustomImageSize extends ConsumerStatefulWidget {
  const CustomImageSize({super.key});

  @override
  ConsumerState<CustomImageSize> createState() => _CustomImageSizeState();
}

class _CustomImageSizeState extends ConsumerState<CustomImageSize> {
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
      title: S.of(context).customImageSize,
      onCancel: () {},
      onOk: onOk,
      child: Column(
        spacing: AppNum.mediumG,
        children: [
          DialogBaseInput(
            controller: controller,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,1}$'))
            ],
            onChanged: (v) {},
          ),
          Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: AppNum.mediumG,
            runSpacing: AppNum.mediumG,
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
