import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/widgets/base/base_input.dart';
import 'package:once_power/widgets/common/click_icon.dart';

class ReplaceDateInput extends ConsumerStatefulWidget {
  const ReplaceDateInput({super.key, this.date, required this.onChange});

  final String? date;
  final void Function(DateTime?) onChange;

  @override
  ConsumerState<ReplaceDateInput> createState() => _ReplaceDateInputState();
}

class _ReplaceDateInputState extends ConsumerState<ReplaceDateInput> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.date);
    // controller.addListener(() {
    //   widget.onChange(DateTime.tryParse(controller.text));
    // });
    // setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppNum.inputH,
      padding: EdgeInsets.symmetric(horizontal: AppNum.defaultP),
      child: BaseInput(
        controller: controller,
        hintText: S.of(context).fileDateSelect,
        showClear: controller.text.isNotEmpty,
        onClear: () {
          controller.clear();
          widget.onChange(null);
        },
        onChanged: (v) {
          DateTime? time = DateTime.tryParse(v);
          if (time != null) {
            controller.text = time.toString();
            widget.onChange(time);
            setState(() {});
          }
        },
        trailing: ClickIcon(
          svg: AppIcons.date,
          onTap: () async {
            DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1970),
              lastDate: DateTime(2100),
              locale: ref.watch(currentLanguageProvider).locale,
              barrierColor: Colors.transparent,
              builder: (context, child) {
                ThemeData themeData = ThemeData.light();
                ThemeMode theme = ref.watch(currentThemeModeProvider);
                if (theme == ThemeMode.system) {
                  final brightness = MediaQuery.of(context).platformBrightness;
                  themeData = brightness == Brightness.dark
                      ? ThemeData.dark()
                      : ThemeData.light();
                }
                if (theme == ThemeMode.dark) themeData = ThemeData.dark();
                return Theme(
                  data: themeData.copyWith(
                    datePickerTheme: themeData.datePickerTheme.copyWith(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // 原圆角过大，改为12
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (selectedDate != null) {
              controller.text = '$selectedDate';
              widget.onChange(selectedDate);
            }
            setState(() {});
          },
        ),
      ),
    );
  }
}
