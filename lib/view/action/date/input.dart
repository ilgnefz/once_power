import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/icons.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/enum/app.dart';
import 'package:once_power/provider/theme.dart';
import 'package:once_power/widget/common/click_icon.dart';
import 'package:once_power/widget/common/input_field.dart';

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
  void didUpdateWidget(covariant TimeInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.date != widget.date) {
      controller.text = widget.date ?? '';
    }
  }

  void onInputChange(String value) {
    DateTime? time = DateTime.tryParse(value);
    if (time != null) {
      // 跨平台最小日期检测
      DateTime adjustedTime = time;
      // 检查年份是否小于系统最小接受值,排除特殊标记值 0000-01-01
      if (time.year != 0 || time.month != 1 || time.day != 1) {
        int year = Platform.isWindows
            ? 1601
            : Platform.isMacOS
            ? 1904
            : 1970;
        DateTime minDate = DateTime(year, 1, 1);

        if (time.isBefore(minDate)) {
          // 如果日期小于系统最小值，调整为系统最小值
          adjustedTime = DateTime(
            minDate.year,
            time.month,
            time.day,
            time.hour,
            time.minute,
            time.second,
            time.millisecond,
          );
        }
      }

      controller.text = adjustedTime.toString();
      widget.onChange(adjustedTime);
      setState(() {});
    }
  }

  void updateDate() async {
    DateTime? currentDateTime = DateTime.tryParse(controller.text);
    DateTime initialDate = DateTime.now();

    // 只有当解析成功且年份在有效范围内时才使用解析的日期
    if (currentDateTime != null &&
        currentDateTime.year >= 1970 &&
        currentDateTime.year <= 2100) {
      initialDate = currentDateTime;
    }

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1970),
      lastDate: DateTime(2100),
      locale: context.locale,
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
        return Theme(
          data: themeData.copyWith(
            datePickerTheme: themeData.datePickerTheme.copyWith(
              backgroundColor: theme == ThemeMode.dark ? null : Colors.white,
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
      DateTime? currentDateTime = DateTime.tryParse(controller.text);
      if (currentDateTime != null) {
        DateTime newDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          currentDateTime.hour,
          currentDateTime.minute,
          currentDateTime.second,
        );
        controller.text = newDateTime.toString();
        widget.onChange(newDateTime);
      } else {
        DateTime newDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
        );
        controller.text = newDateTime.toString();
        widget.onChange(newDateTime);
      }
    }
    setState(() {});
  }

  void updateTime() async {
    DateTime? currentDateTime = DateTime.tryParse(controller.text);
    TimeOfDay initialTime = currentDateTime != null
        ? TimeOfDay(hour: currentDateTime.hour, minute: currentDateTime.minute)
        : TimeOfDay.now();

    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
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
        return Theme(
          data: themeData.copyWith(
            timePickerTheme: themeData.timePickerTheme.copyWith(
              backgroundColor: theme == ThemeMode.dark ? null : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedTime != null) {
      DateTime? currentDate = DateTime.tryParse(controller.text);
      if (currentDate != null) {
        DateTime newDateTime = DateTime(
          currentDate.year,
          currentDate.month,
          currentDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        controller.text = newDateTime.toString();
        widget.onChange(newDateTime);
      } else {
        // 当controller.text为空时，创建0000-00-00+time的DateTime
        DateTime newDateTime = DateTime(
          0, // 年: 0000
          1, // 月: 01
          1, // 日: 01
          selectedTime.hour,
          selectedTime.minute,
        );
        controller.text = newDateTime.toString();
        widget.onChange(newDateTime);
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppNum.padding),
      child: InputField(
        controller: controller,
        hintText: tr(AppL10n.dateHint),
        onClear: () {
          controller.clear();
          widget.onChange(null);
        },
        onChanged: onInputChange,
        action: Row(
          children: [
            ClickIcon(
              icon: Icons.access_time_filled_outlined,
              onPressed: updateTime,
            ),
            ClickIcon(svg: AppIcons.date, onPressed: updateDate),
          ],
        ),
      ),
    );
  }
}
