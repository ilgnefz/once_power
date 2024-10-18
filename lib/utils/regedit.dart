import 'dart:io';

import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:win32_registry/win32_registry.dart';

String appName = AppText.name;

/// 关闭软件后显示的右键快捷菜单
void createGlobalRegedit() {
  if (!Platform.isWindows) return;

  final reg = Registry.currentUser;
  String appPath = Platform.resolvedExecutable;

  // String fileRegKey = r'Software\Classes\*\shell\' + appName;
  String folderRegKey = r'Software\Classes\Directory\shell\' + appName;
  String backgroundRegKey =
      r'Software\Classes\Directory\Background\shell\' + appName;
  String cmdRegKey = 'command';

  RegistryValue labelRegValue = RegistryValue(
    '',
    RegistryValueType.string,
    '${S.current.shortcutTip1} $appName',
  );
  RegistryValue iconRegValue = RegistryValue(
    'Icon',
    RegistryValueType.string,
    appPath,
  );
  RegistryValue cmdRegValue = RegistryValue(
    '',
    RegistryValueType.unexpandedString,
    '"$appPath" "%V"',
  );

  // final fileKey = reg.createKey(fileRegKey);
  // fileKey.createValue(labelRegValue);
  // fileKey.createValue(iconRegValue);
  // fileKey.createKey(cmdRegKey).createValue(cmdRegValue);
  // fileKey.close();

  final folderKey = reg.createKey(folderRegKey);
  folderKey.createValue(labelRegValue);
  folderKey.createValue(iconRegValue);
  folderKey.createKey(cmdRegKey).createValue(cmdRegValue);
  folderKey.close();

  final backgroundKey = reg.createKey(backgroundRegKey);
  backgroundKey.createValue(labelRegValue);
  backgroundKey.createValue(iconRegValue);
  backgroundKey.createKey(cmdRegKey).createValue(cmdRegValue);
  backgroundKey.close();

  reg.close();
}

void removeGlobalRegedit() {
  if (!Platform.isWindows) return;
  String appName = AppText.name;
  final reg = Registry.currentUser;
  String folderRegKey = r'Software\Classes\Directory\shell\' + appName;
  String backgroundRegKey =
      r'Software\Classes\Directory\Background\shell\' + appName;

  reg.deleteKey(folderRegKey, recursive: true);
  reg.deleteKey(backgroundRegKey, recursive: true);

  reg.close();
}

/// 软件运行时显示的右键快捷菜单
void createLocalRegedit() async {
  if (!Platform.isWindows) return;

  final reg = Registry.currentUser;
  String appPath = Platform.resolvedExecutable;

  String fileRegKey = r'Software\Classes\*\shell\' + appName;
  String folderRegKey = r'Software\Classes\Directory\shell\' + appName;
  String cmdRegKey = 'command';

  RegistryValue labelRegValue = RegistryValue(
    '',
    RegistryValueType.string,
    '${S.current.shortcutTip2} $appName',
  );
  RegistryValue iconRegValue = RegistryValue(
    'Icon',
    RegistryValueType.string,
    appPath,
  );
  RegistryValue cmdRegValue = RegistryValue(
    '',
    RegistryValueType.unexpandedString,
    '$appPath shortcut_menu_extender --key $appName --path "%V"',
  );

  final fileKey = reg.createKey(fileRegKey);
  fileKey.createValue(labelRegValue);
  fileKey.createValue(iconRegValue);
  fileKey.createKey(cmdRegKey).createValue(cmdRegValue);
  fileKey.close();

  final folderKey = reg.createKey(folderRegKey);
  folderKey.createValue(labelRegValue);
  folderKey.createValue(iconRegValue);
  folderKey.createKey(cmdRegKey).createValue(cmdRegValue);
  folderKey.close();
  reg.close();
}

void removeLocalRegedit() {
  if (!Platform.isWindows) return;

  String appName = AppText.name;
  final reg = Registry.currentUser;
  String fileRegKey = r'Software\Classes\*\shell\' + appName;
  String folderRegKey = r'Software\Classes\Directory\shell\' + appName;

  reg.deleteKey(fileRegKey, recursive: true);
  reg.deleteKey(folderRegKey, recursive: true);

  reg.close();
}

// void createLocalRegedit() async {
//   if (!Platform.isWindows) return;
//   await shortcutMenuExtender.register(
//     appName,
//     name: '${S.current.shortcutTip2} $appName',
//     executable: Platform.resolvedExecutable,
//     useDefaultIcon: true,
//   );
// }
//
// void removeLocalRegedit() async {
//   if (!Platform.isWindows) return;
//   await shortcutMenuExtender.unregister(appName);
// }
