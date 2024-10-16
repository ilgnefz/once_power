import 'dart:io';

import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:path/path.dart';
import 'package:shortcut_menu_extender/shortcut_menu_extender.dart';
import 'package:win32_registry/win32_registry.dart';

String appName = AppText.name;

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

void createLocalRegedit() async {
  if (!Platform.isWindows) return;
  await shortcutMenuExtender.register(
    appName,
    name: '${S.current.shortcutTip2} $appName',
    executable: Platform.resolvedExecutable,
    useDefaultIcon: true,
  );
}

void removeLocalRegedit() async {
  if (!Platform.isWindows) return;
  await shortcutMenuExtender.unregister(appName);
}
