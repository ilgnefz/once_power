import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:once_power/const/key.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/util/storage.dart';
import 'package:once_power/widget/base/dialog.dart';
import 'package:once_power/widget/common/input_field.dart';
import 'package:once_power/widget/common/link_text.dart';

class KeyInputView extends StatefulWidget {
  const KeyInputView({super.key});

  @override
  State<KeyInputView> createState() => _KeyInputViewState();
}

class _KeyInputViewState extends State<KeyInputView> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    String? key = StorageUtil.getString(AppKeys.mapKey);
    _controller = TextEditingController(text: key);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EasyDialog(
      title: tr(AppL10n.advanceLocationTitle),
      content: Column(
        spacing: 8,
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          InputField(
            controller: _controller,
            hintText: tr(AppL10n.advanceLocationHint),
            obscureText: true,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
            ],
            onClear: () async {
              _controller.clear();
              setState(() {});
              await StorageUtil.remove(AppKeys.mapKey);
            },
          ),
          LinkText(
            text: tr(AppL10n.advanceLocationNote),
            clickText: tr(AppL10n.advanceLocationLink),
            link: 'https://console.amap.com/dev/key/app',
          ),
        ],
      ),
      onOk: () => StorageUtil.setString(AppKeys.mapKey, _controller.text),
    );
  }
}
