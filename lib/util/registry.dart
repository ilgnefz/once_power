import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/text.dart';
import 'package:win32_registry/win32_registry.dart';

class AppRegistry {
  static String appName = AppText.appName;
  static String appPath = Platform.resolvedExecutable;
  static String fileKey = r'Software\Classes\*\shell\' + appName;
  static String folderKey = r'Software\Classes\Directory\shell\' + appName;
  static String backgroundKey =
      r'Software\Classes\Directory\Background\shell\' + appName;

  static void addRunning() async {
    RegistryKey reg = Registry.currentUser;

    RegistryValue labelValue = RegistryValue.string(
      '',
      '${tr(AppL10n.bottomRegeditTip2)} $appName',
    );
    RegistryValue iconValue = RegistryValue.string('Icon', appPath);
    String cmdKey = 'command';
    RegistryValue cmdValue = RegistryValue.unexpandedString(
      '',
      '$appPath shortcut_menu_extender --key $appName --path "%V"',
    );

    _createRegister(reg, fileKey, labelValue, iconValue, cmdKey, cmdValue);
    _createRegister(reg, folderKey, labelValue, iconValue, cmdKey, cmdValue);

    reg.close();
  }

  static void removeRunning() async {
    RegistryKey reg = Registry.currentUser;

    reg.deleteKey(fileKey, recursive: true);
    reg.deleteKey(folderKey, recursive: true);

    reg.close();
  }

  static void addClosed() async {
    RegistryKey reg = Registry.currentUser;

    RegistryValue labelValue = RegistryValue.string(
      '',
      '${tr(AppL10n.bottomRegeditTip1)} $appName',
    );
    RegistryValue iconValue = RegistryValue.string('Icon', appPath);
    String cmdKey = 'command';
    RegistryValue cmdValue = RegistryValue.unexpandedString(
      '',
      '"$appPath" "%V"',
    );

    _createRegister(reg, folderKey, labelValue, iconValue, cmdKey, cmdValue);
    _createRegister(
      reg,
      backgroundKey,
      labelValue,
      iconValue,
      cmdKey,
      cmdValue,
    );

    reg.close();
  }

  static void removeClosed() async {
    RegistryKey reg = Registry.currentUser;

    reg.deleteKey(folderKey, recursive: true);
    reg.deleteKey(backgroundKey, recursive: true);

    reg.close();
  }
}

void _createRegister(
  RegistryKey reg,
  String key,
  RegistryValue label,
  RegistryValue icon,
  String cmdKey,
  RegistryValue cmd,
) {
  final fileKey = reg.createKey(key);
  fileKey.createValue(label);
  fileKey.createValue(icon);
  fileKey.createKey(cmdKey).createValue(cmd);
  fileKey.close();
}

// import 'dart:io';
//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:once_power/const/l10n.dart';
// import 'package:once_power/const/text.dart';
// import 'package:shortcut_menu_extender/shortcut_menu_extender.dart';
//
// class AppRegistry {
//   static String appName = AppText.appName;
//   static void register() {
//     shortcutMenuExtender.register(
//       appName,
//       name: '${tr(AppL10n.bottomRegeditTip2)} $appName',
//       executable: Platform.resolvedExecutable,
//       useDefaultIcon: true,
//     );
//   }
//
//   static void unregister() {
//     shortcutMenuExtender.unregister(AppText.appName);
//   }
// }
