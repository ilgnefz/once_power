import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/enums/app.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/widgets/base/base_input.dart';
import 'package:once_power/widgets/base/dialog_background.dart';
import 'package:once_power/widgets/common/click_icon.dart';

class TimeInput extends ConsumerStatefulWidget {
  const TimeInput({super.key, this.date, required this.onChange});

  final String? date;
  final void Function(DateTime?) onChange;

  @override
  ConsumerState<TimeInput> createState() => _TimeInputState();
}

class _TimeInputState extends ConsumerState<TimeInput> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.date);
    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppNum.padding),
      child: BaseInput(
        controller: controller,
        hintText: tr(AppL10n.dateHint),
        show: controller.text.isNotEmpty,
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
          onPressed: () async {
            DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1970),
              lastDate: DateTime(2100),
              locale: context.locale,
              barrierColor: Colors.transparent,
              builder: (context, child) {
                ThemeData themeData = ThemeData.light();
                ThemeMode theme = ref.watch(currentThemeProvider).mode;
                if (theme == ThemeMode.system) {
                  final brightness = MediaQuery.of(context).platformBrightness;
                  themeData = brightness == Brightness.dark
                      ? ThemeData.dark()
                      : ThemeData.light();
                }
                if (theme == ThemeMode.dark) themeData = ThemeData.dark();
                return DialogBackground(
                  child: Theme(
                    data: themeData.copyWith(
                      datePickerTheme: themeData.datePickerTheme.copyWith(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // 原圆角过大，改为12
                        ),
                      ),
                    ),
                    child: child!,
                  ),
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
