import 'dart:io';

import 'package:once_power/constants/string.dart';
import 'package:win32_registry/win32_registry.dart';

class AppRegedit {
  static String appName = AppString.appName;

  /// 关闭软件后显示的右键快捷菜单
  static void createGlobalRegedit() {
    if (!Platform.isWindows) return;

    final reg = Registry.currentUser;
    String appPath = Platform.resolvedExecutable;

    // String fileRegKey = r'Software\Classes\*\shell\' + appName;
    String folderRegKey = r'Software\Classes\Directory\shell\' + appName;
    String backgroundRegKey =
        r'Software\Classes\Directory\Background\shell\' + appName;
    String cmdRegKey = 'command';

    RegistryValue labelRegValue = RegistryValue.string(
      '',
      'shortcutTip1 $appName', // TODO: 翻译
    );
    RegistryValue iconRegValue = RegistryValue.string('Icon', appPath);
    RegistryValue cmdRegValue = RegistryValue.unexpandedString(
      '',
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

  static void removeGlobalRegedit() {
    if (!Platform.isWindows) return;
    final reg = Registry.currentUser;
    String folderRegKey = r'Software\Classes\Directory\shell\' + appName;
    String backgroundRegKey =
        r'Software\Classes\Directory\Background\shell\' + appName;

    reg.deleteKey(folderRegKey, recursive: true);
    reg.deleteKey(backgroundRegKey, recursive: true);

    reg.close();
  }

  /// 软件运行时显示的右键快捷菜单
  static void createLocalRegedit() async {
    if (!Platform.isWindows) return;

    final reg = Registry.currentUser;
    String appPath = Platform.resolvedExecutable;

    String fileRegKey = r'Software\Classes\*\shell\' + appName;
    String folderRegKey = r'Software\Classes\Directory\shell\' + appName;
    String cmdRegKey = 'command';

    RegistryValue labelRegValue = RegistryValue.string(
      '',
      'shortcutTip2 $appName', // TODO: 翻译
    );
    RegistryValue iconRegValue = RegistryValue.string('Icon', appPath);
    RegistryValue cmdRegValue = RegistryValue.unexpandedString(
      '',
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

  static void removeLocalRegedit() {
    if (!Platform.isWindows) return;
    final reg = Registry.currentUser;
    String fileRegKey = r'Software\Classes\*\shell\' + appName;
    String folderRegKey = r'Software\Classes\Directory\shell\' + appName;

    reg.deleteKey(fileRegKey, recursive: true);
    reg.deleteKey(folderRegKey, recursive: true);

    reg.close();
  }
}
