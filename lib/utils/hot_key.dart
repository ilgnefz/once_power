import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:once_power/cores/list.dart';
import 'package:once_power/cores/sort.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/providers/file.dart';

class AppHotKey {
  static Future<void> registerHotkeys(
    HotKey hotKey,
    VoidCallback keyDownHandler,
    VoidCallback? keyUpHandler,
  ) async {
    await hotKeyManager.register(
      hotKey,
      keyDownHandler: (hotKey) {
        keyDownHandler();
        // print('onKeyDown+${hotKey.toJson()}');
      },
      // Only works on macOS.
      keyUpHandler: (hotKey) {
        keyUpHandler?.call();
        // print('onKeyUp+${hotKey.toJson()}');
      },
    );
  }

  static Future<void> unregisterHotkeys(HotKey hotKey) async {
    await hotKeyManager.unregister(hotKey);
  }

  static Future<void> unregisterAllHotkeys() async {
    await hotKeyManager.unregisterAll();
  }

  static Future<void> init(WidgetRef ref) async {
    List<HotKeyModel> hotKeys = [
      HotKeyModel(
        hotkey: HotKey(
          key: LogicalKeyboardKey.delete,
          modifiers: [],
          scope: HotKeyScope.inapp,
        ),
        keyDownHandler: () {
          List<FileInfo> list = ref.read(sortSelectListProvider);
          if (list.isNotEmpty) {
            for (FileInfo file in list) {
              ref.read(fileListProvider.notifier).remove(file.id);
            }
            ref.read(sortSelectListProvider.notifier).clear();
          }
        },
      ),
      HotKeyModel(
        hotkey: HotKey(
          key: LogicalKeyboardKey.keyZ,
          modifiers: [HotKeyModifier.control],
          scope: HotKeyScope.inapp,
        ),
        keyDownHandler: () =>
            suspenseFileList(ref, ref.watch(sortSelectListProvider)),
      ),
      HotKeyModel(
        hotkey: HotKey(
          key: LogicalKeyboardKey.keyX,
          modifiers: [HotKeyModifier.control],
          scope: HotKeyScope.inapp,
        ),
        keyDownHandler: () {
          List<FileInfo> files = ref.watch(sortSelectListProvider);
          if (files.isNotEmpty) toTheFront(ref, files.last);
        },
      ),
      HotKeyModel(
        hotkey: HotKey(
          key: LogicalKeyboardKey.keyC,
          modifiers: [HotKeyModifier.control],
          scope: HotKeyScope.inapp,
        ),
        keyDownHandler: () {
          List<FileInfo> files = ref.watch(sortSelectListProvider);
          if (files.isNotEmpty) toTheBehind(ref, files.last);
        },
      ),
      HotKeyModel(
        hotkey: HotKey(
          key: LogicalKeyboardKey.keyS,
          modifiers: [HotKeyModifier.control],
          scope: HotKeyScope.inapp,
        ),
        keyDownHandler: () {
          List<FileInfo> files = ref.watch(sortSelectListProvider);
          toggleMultipleCheck(ref, files);
        },
      ),
    ];

    for (var hotkey in hotKeys) {
      await registerHotkeys(
        hotkey.hotkey,
        hotkey.keyDownHandler,
        hotkey.keyUpHandler,
      );
    }
  }
}

class HotKeyModel {
  final HotKey hotkey;
  final VoidCallback keyDownHandler;
  final VoidCallback? keyUpHandler;

  HotKeyModel({
    required this.hotkey,
    required this.keyDownHandler,
    this.keyUpHandler,
  });
}
