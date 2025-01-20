import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/advance_menu.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/model/notification_info.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/utils/format.dart';
import 'package:once_power/views/action_bar/advance/add_position_radio.dart';
import 'package:once_power/views/action_bar/advance/dialog/add_type_group.dart';
import 'package:once_power/views/action_bar/advance/dialog/case_conversion_group.dart';
import 'package:once_power/views/action_bar/advance/dialog/common_base_input.dart';
import 'package:once_power/views/action_bar/advance/dialog/common_dialog.dart';
import 'package:once_power/views/action_bar/advance/dialog/common_location_group.dart';
import 'package:once_power/views/action_bar/advance/dialog/num_input_group.dart';
import 'package:once_power/widgets/common/notification.dart';

void deleteText(BuildContext context, WidgetRef ref,
    [AdvanceMenuDelete? menu]) {
  showDialog(
    context: context,
    builder: (context) {
      String value = menu != null ? menu.value : '';
      MatchLocation location =
          menu != null ? menu.matchLocation : MatchLocation.first;
      return StatefulBuilder(
        builder: (context, setState) => CommonDialog(
          title: S.of(context).deleteTitle,
          child: Column(
            spacing: AppNum.mediumG,
            children: [
              CommonBaseInput(
                value: value,
                hintText: S.of(context).deleteInputHint,
                onChanged: (v) {
                  value = v;
                  setState(() {});
                },
              ),
              CommonLocationRadio(
                location: location,
                onChanged: (value) {
                  location = value;
                  setState(() {});
                },
              ),
            ],
          ),
          onOk: () {
            String id = menu != null ? menu.id : nanoid(10);
            AdvanceMenuDelete delete = AdvanceMenuDelete(
              id: id,
              value: value,
              matchLocation: location,
            );
            if (menu != null) {
              ref
                  .read(advanceMenuListProvider.notifier)
                  .update(menu.id, delete);
            } else {
              ref.read(advanceMenuListProvider.notifier).add(delete);
            }
            advanceUpdateName(ref);
          },
        ),
      );
    },
  );
}

void addText(BuildContext context, WidgetRef ref, [AdvanceMenuAdd? menu]) {
  showDialog(
    context: context,
    builder: (context) {
      String value = menu != null ? menu.value : '';
      int digits = menu != null ? menu.digits : 0;
      int start = menu != null ? menu.start : 0;
      AddType type = menu != null ? menu.addType : AddType.text;
      AddPosition position =
          menu != null ? menu.addPosition : AddPosition.after;
      return StatefulBuilder(
        builder: (context, setState) {
          return CommonDialog(
            title: S.of(context).addTitle,
            child: Column(
              spacing: AppNum.mediumG,
              children: [
                CommonBaseInput(
                    value: value,
                    hintText: S.of(context).addInputHint,
                    onChanged: (v) {
                      value = v;
                      setState(() {});
                    }),
                NumInputGroup(
                  digits: digits,
                  start: start,
                  onDigitsChanged: (v) {
                    digits = int.parse(v);
                    setState(() {});
                  },
                  onStartChanged: (v) {
                    start = int.parse(v);
                    setState(() {});
                  },
                ),
                AddTypeRadio(
                  type: type,
                  typeChanged: (value) {
                    type = value;
                    setState(() {});
                  },
                ),
                AddPositionRadio(
                  position: position,
                  positionChanged: (value) {
                    position = value;
                    setState(() {});
                  },
                ),
              ],
            ),
            onOk: () {
              String id = menu != null ? menu.id : nanoid(10);
              AdvanceMenuAdd add = AdvanceMenuAdd(
                id: id,
                value: value,
                digits: digits,
                start: start,
                addType: type,
                addPosition: position,
              );
              if (menu != null) {
                ref.read(advanceMenuListProvider.notifier).update(menu.id, add);
              } else {
                ref.read(advanceMenuListProvider.notifier).add(add);
              }
              advanceUpdateName(ref);
            },
          );
        },
      );
    },
  );
}

void replaceText(BuildContext context, WidgetRef ref,
    [AdvanceMenuReplace? menu]) {
  showDialog(
    context: context,
    builder: (context) {
      String oldValue = menu != null ? menu.value[0] : '';
      String newValue = menu != null ? menu.value[1] : '';
      MatchLocation location =
          menu != null ? menu.matchLocation : MatchLocation.first;
      CaseType type = menu != null ? menu.caseType : CaseType.noConversion;
      return CommonDialog(
        title: S.of(context).replaceTitle,
        child: StatefulBuilder(
          builder: (context, setState) => Form(
            child: Column(
              spacing: AppNum.mediumG,
              children: [
                CommonBaseInput(
                  value: oldValue,
                  hintText: S.of(context).replaceInputHint,
                  onChanged: (value) {
                    oldValue = value;
                    setState(() {});
                  },
                ),
                CommonBaseInput(
                  value: newValue,
                  hintText: S.of(context).replaceInputHint2,
                  onChanged: (value) {
                    newValue = value;
                    setState(() {});
                  },
                ),
                CommonLocationRadio(
                  location: location,
                  onChanged: (value) {
                    location = value;
                    setState(() {});
                  },
                ),
                CaseConversionGroup(
                  type: type,
                  typeChanged: (value) {
                    type = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
        onOk: () {
          String id = menu != null ? menu.id : nanoid(10);
          AdvanceMenuReplace replace = AdvanceMenuReplace(
            id: id,
            value: [oldValue, newValue],
            matchLocation: location,
            caseType: type,
          );
          if (menu != null) {
            ref.read(advanceMenuListProvider.notifier).update(menu.id, replace);
          } else {
            ref.read(advanceMenuListProvider.notifier).add(replace);
          }
          advanceUpdateName(ref);
        },
      );
    },
  );
}

void addPreset(BuildContext context, WidgetRef ref) {
  List<AdvanceMenuModel> menus = ref.watch(advanceMenuListProvider);
  if (menus.isEmpty) return;
  showDialog(
    context: context,
    builder: (context) {
      String name = '';
      return CommonDialog(
        title: S.of(context).presetName,
        autoPop: false,
        onOk: () {
          if (name == '') {
            NotificationType type = ErrorNotification(
                S.of(context).presetNameErrorTitle,
                S.of(context).presetNameError);
            NotificationMessage.show(type, 0, 2);
            return;
          }
          AdvancePreset preset =
              AdvancePreset(id: nanoid(10), name: name, menus: menus);
          ref.read(advancePresetListProvider.notifier).add(preset);
          Navigator.of(context).pop();
        },
        child: StatefulBuilder(
          builder: (context, setState) => CommonBaseInput(
            value: name,
            hintText: S.of(context).presetNameHint,
            onChanged: (v) {
              name = v;
              setState(() {});
            },
          ),
        ),
      );
    },
  );
}

void advanceUpdateName(WidgetRef ref) {
  List<FileInfo> fileList = ref.watch(sortListProvider);
  List<AdvanceMenuModel> menus = ref.watch(advanceMenuListProvider);
  int index = 0;
  for (FileInfo file in fileList) {
    if (file.checked) {
      String name = file.name;
      for (AdvanceMenuModel menu in menus) {
        if (menu.type.isDelete) {
          name = advanceDeleteName(menu as AdvanceMenuDelete, name);
        }
        if (menu.type.isAdd) {
          name = advanceAddName(menu as AdvanceMenuAdd, name, index);
        }
        if (menu.type.isReplace) {
          name = advanceReplaceName(menu as AdvanceMenuReplace, name);
        }
      }
      ref.read(fileListProvider.notifier).updateName(file.id, name);
      index++;
    } else {
      ref.read(fileListProvider.notifier).updateName(file.id, file.name);
    }
  }
}

String advanceDeleteName(AdvanceMenuDelete menu, String name) {
  String value = menu.value;
  MatchLocation location = menu.matchLocation;
  switch (location) {
    case MatchLocation.first:
      name = name.replaceFirst(value, '');
      return name;
    case MatchLocation.last:
      int index = name.lastIndexOf(value);
      if (index != -1) {
        name = name.substring(0, index) + name.substring(index + value.length);
      }
      return name;
    case MatchLocation.all:
      name = name.replaceAll(value, '');
      return name;
  }
}

String advanceAddName(AdvanceMenuAdd menu, String name, int index) {
  String value = menu.value;
  int digits = menu.digits;
  int start = menu.start + index;
  AddType addType = menu.addType;
  AddPosition addPosition = menu.addPosition;
  if (addType.isText) {
    name = addPosition.isBefore ? '$value$name' : '$name$value';
  }
  if (addType.isSerialNumber) {
    String num = formatNumber(start, digits);
    name = addPosition.isBefore ? '$num$name' : '$name$num';
  }
  return name;
}

String advanceReplaceName(AdvanceMenuReplace menu, String name) {
  String oldValue = menu.value[0];
  String newValue = menu.value[1];
  CaseType type = menu.caseType;
  if (type.isNoConversion) {
    MatchLocation location = menu.matchLocation;
    switch (location) {
      case MatchLocation.first:
        name = name.replaceFirst(oldValue, newValue);
        return name;
      case MatchLocation.last:
        int index = name.lastIndexOf(oldValue);
        if (index != -1) {
          name = name.substring(0, index) +
              name.substring(index + oldValue.length) +
              newValue;
        }
        return name;
      case MatchLocation.all:
        name = name.replaceAll(oldValue, newValue);
        return name;
    }
  } else {
    switch (type) {
      case CaseType.uppercase:
        name = name.toUpperCase();
        return name;
      case CaseType.lowercase:
        name = name.toLowerCase();
        return name;
      case CaseType.toggleCase:
        String result = '';
        for (int i = 0; i < name.length; i++) {
          String char = name[i];
          if (char == char.toUpperCase()) {
            result += char.toLowerCase();
          } else {
            result += char.toUpperCase();
          }
        }
        return result;
      case CaseType.noConversion:
        return name;
    }
  }
}
