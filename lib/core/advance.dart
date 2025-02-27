import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/advance_menu.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/model/notification_info.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/format.dart';
import 'package:once_power/views/action_bar/advance/dialog/add_distinguish_group.dart';
import 'package:once_power/views/action_bar/advance/dialog/add_position_radio.dart';
import 'package:once_power/views/action_bar/advance/dialog/add_type_group.dart';
import 'package:once_power/views/action_bar/advance/dialog/case_conversion_group.dart';
import 'package:once_power/views/action_bar/advance/dialog/common_base_input.dart';
import 'package:once_power/views/action_bar/advance/dialog/common_dialog.dart';
import 'package:once_power/views/action_bar/advance/dialog/common_location_group.dart';
import 'package:once_power/views/action_bar/advance/dialog/delete_type_group.dart';
import 'package:once_power/views/action_bar/advance/dialog/format_group.dart';
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
      int start = menu != null ? menu.start : 1;
      int end = menu != null ? menu.end : 1;
      List<DeleteType> deleteTypes = menu != null ? menu.deleteTypes : [];
      return StatefulBuilder(
        builder: (context, setState) => CommonDialog(
          title: S.of(context).deleteTitle,
          child: Column(
            spacing: AppNum.mediumG,
            children: [
              CommonBaseInput(
                value: value,
                hintText: S.of(context).deleteInputHint,
                onChanged: (newValue) {
                  value = newValue;
                  setState(() {});
                },
              ),
              CommonLocationRadio(
                location: location,
                onChanged: (value) {
                  location = value;
                  setState(() {});
                },
                start: start,
                end: end,
                onStartChanged: (value) {
                  start = value;
                  setState(() {});
                },
                onEndChanged: (value) {
                  end = value;
                  setState(() {});
                },
              ),
              DeleteTypeGroup(
                deleteTypes: deleteTypes,
                onChanged: (value) {
                  if (deleteTypes.contains(value)) {
                    deleteTypes.remove(value);
                  } else {
                    deleteTypes.add(value);
                  }
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
              start: start,
              end: end,
              deleteTypes: deleteTypes,
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
      int posIndex = menu != null ? menu.posIndex : 1;
      DistinguishType distinguishType =
          menu != null ? menu.distinguishType : DistinguishType.none;
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
                    onChanged: (newValue) {
                      value = newValue;
                      setState(() {});
                    }),
                NumInputGroup(
                  digits: digits,
                  start: start,
                  onDigitsChanged: (value) {
                    digits = value;
                    setState(() {});
                  },
                  onStartChanged: (value) {
                    start = value;
                    setState(() {});
                  },
                ),
                AddSerialDistinguish(
                  type: distinguishType,
                  typeChanged: (value) {
                    distinguishType = value;
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
                  addPosition: position,
                  positionChanged: (value) {
                    position = value;
                    setState(() {});
                  },
                  posIndex: posIndex,
                  posIndexChanged: (value) {
                    posIndex = value;
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
                distinguishType: distinguishType,
                addPosition: position,
                posIndex: posIndex,
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
      ReplaceMode mode = menu != null ? menu.replaceMode : ReplaceMode.normal;
      MatchLocation location =
          menu != null ? menu.matchLocation : MatchLocation.first;
      int start = menu != null ? menu.start : 1;
      int end = menu != null ? menu.end : 1;
      CaseType type = menu != null ? menu.caseType : CaseType.noConversion;
      return CommonDialog(
        title: S.of(context).replaceTitle,
        child: StatefulBuilder(
          builder: (context, setState) {
            bool isFormat = ref.watch(currentReplaceModeProvider).isFormat;
            return Form(
              child: Column(
                spacing: AppNum.mediumG,
                children: [
                  CommonBaseInput(
                    value: oldValue,
                    hintText: isFormat
                        ? S.of(context).formatDigit
                        : S.of(context).replaceInputHint,
                    inputFormatters: isFormat
                        ? [FilteringTextInputFormatter.digitsOnly]
                        : [],
                    onChanged: (value) {
                      oldValue = value;
                      setState(() {});
                    },
                  ),
                  CommonBaseInput(
                    value: newValue,
                    hintText: isFormat
                        ? S.of(context).completeContent
                        : S.of(context).replaceInputHint2,
                    onChanged: (value) {
                      newValue = value;
                      setState(() {});
                    },
                  ),
                  FormatGroup(
                      mode: mode,
                      onChanged: (value) {
                        mode = value;
                        String temp = oldValue;
                        if (mode.isFormat) {
                          bool isNum = int.tryParse(oldValue) != null;
                          if (!isNum) oldValue = oldValue.length.toString();
                        }
                        if (mode.isNormal) oldValue = temp;
                        ref
                            .read(currentReplaceModeProvider.notifier)
                            .update(mode);
                        setState(() {});
                      }),
                  CommonLocationRadio(
                    location: location,
                    onChanged: (value) {
                      location = value;
                      setState(() {});
                    },
                    start: start,
                    end: end,
                    onStartChanged: (value) {
                      start = value;
                      setState(() {});
                    },
                    onEndChanged: (value) {
                      end = value;
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
            );
          },
        ),
        onOk: () {
          String id = menu != null ? menu.id : nanoid(10);
          AdvanceMenuReplace replace = AdvanceMenuReplace(
            id: id,
            value: [oldValue, newValue],
            replaceMode: mode,
            matchLocation: location,
            start: start,
            end: end,
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
            onChanged: (value) {
              name = value;
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
  Map<String, List<FileInfo>> classifyMap = {};
  for (FileInfo file in fileList) {
    if (file.checked) {
      String name = file.name;
      for (AdvanceMenuModel menu in menus) {
        if (menu.type.isDelete) {
          name = advanceDeleteName(menu as AdvanceMenuDelete, name);
        }
        if (menu.type.isAdd) {
          menu as AdvanceMenuAdd;
          String folder = getFolderName(file.parent);
          String extension = file.extension;
          String type = file.type.value;
          if (menu.distinguishType.isFolder) {
            index = calculateIndex(classifyMap, folder, file);
          }
          if (menu.distinguishType.isExtension) {
            index = calculateIndex(classifyMap, extension, file);
          }
          if (menu.distinguishType.isFile) {
            index = calculateIndex(classifyMap, type, file);
          }
          name = advanceAddName(menu, name, index, folder);
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
  List<DeleteType> deleteTypes = menu.deleteTypes;
  if (deleteTypes.isNotEmpty) {
    for (DeleteType type in deleteTypes) {
      switch (type) {
        case DeleteType.digit:
          name = name.replaceAll(RegExp(r'[0-9]'), '');
          break;
        case DeleteType.capitalLetter:
          name = name.replaceAll(RegExp(r'[A-Z]'), '');
          break;
        case DeleteType.lowercaseLetters:
          name = name.replaceAll(RegExp(r'[a-z]'), '');
          break;
        case DeleteType.nonLetter:
          String pattern =
              r'\u4e00-\u9fff\u3040-\u309f\u30a0-\u30ff\uac00-\ud7af\u0f00-\u0fff';
          name = name.replaceAll(RegExp("[$pattern]"), '');
          break;
        case DeleteType.punctuation:
          String pattern =
              r"()\~!@#\$%\^&,'\.;_\[\]`\{\}\-=+！，。？：、‘’“”（）【】{}<>《》「」";
          name = name.replaceAll(RegExp("[$pattern]"), '');
          break;
        case DeleteType.space:
          name = name.replaceAll(' ', '');
          break;
      }
    }
    return name;
  }
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
    case MatchLocation.position:
      return matchPosition(name, '', menu.start, menu.end);
  }
}

String advanceAddName(
    AdvanceMenuAdd menu, String name, int index, String folder) {
  String value = menu.value;
  int digits = menu.digits;
  int start = menu.start + index;
  AddType addType = menu.addType;
  AddPosition addPosition = menu.addPosition;
  int posIndex = menu.posIndex;
  if (!addType.isSerialNumber) {
    // name = addPosition.isBefore ? '$value$name' : '$name$value';
    value = addType.isParentsName ? folder : value;
    switch (addPosition) {
      case AddPosition.before:
        name = '$value$name';
        break;
      case AddPosition.after:
        name = '$name$value';
        break;
      case AddPosition.position:
        if (posIndex > name.length) {
          posIndex = name.length;
          name = '$name$value';
        } else {
          String left = name.substring(0, posIndex - 1);
          String right = name.substring(posIndex - 1);
          name = '$left$value$right';
        }
    }
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
  ReplaceMode mode = menu.replaceMode;
  if (mode.isFormat) {
    int num = int.parse(oldValue);
    if (name.length > num) {
      name = name.substring(0, num);
    } else {
      name = name.padLeft(num, newValue);
    }
    return name;
  }
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
      case MatchLocation.position:
        return matchPosition(name, newValue, menu.start, menu.end);
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

String matchPosition(String name, String replaceStr, int start, int end) {
  if (start > name.length) return name;
  if (end > name.length || end < start) end = name.length;
  String left = name.substring(0, start - 1);
  String right = name.substring(end);
  return left + replaceStr + right;
}

// int rulesIndex(WidgetRef ref, DistinguishType distinguishType) {
//   int index = 0;
//   Map<String, List<FileInfo>> classifyMap = {};
//   List<FileInfo> files = ref.watch(sortListProvider);
//   for (FileInfo file in files) {
//     if (!file.checked) continue;
//     String folder = getFolderName(file.parent);
//     String extension = file.extension;
//     String type = file.type.value;
//     if (distinguishType.isFolder) {
//       index = calculateIndex(classifyMap, folder, file);
//     }
//     if (distinguishType.isExtension) {
//       index = calculateIndex(classifyMap, extension, file);
//     }
//     if (distinguishType.isFile) {
//       index = calculateIndex(classifyMap, type, file);
//     }
//   }
//   return index;
// }

int calculateIndex(
  Map<String, List<FileInfo>> classifyMap,
  String key,
  FileInfo file,
) {
  List<String> keyList = classifyMap.keys.toList();
  if (!keyList.contains(key)) {
    classifyMap[key] = [];
  }
  classifyMap[key]!.add(file);
  return classifyMap[key]!.indexOf(file);
}
