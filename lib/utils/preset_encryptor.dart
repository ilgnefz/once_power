import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart' show listEquals;
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu.dart';

class PresetEncryptor {
  // 自定义文件后缀
  static const String extension = 'oprt';
  // 自定义文件mimeTyp
  static const String mimeType = 'application/vnd.oncepower.preset+$extension';
  // 固定头标识（与业务强相关，建议作为常量）
  static const String header = 'ONCE_PRESET_V1';
  // 固定32字节密钥（实际需替换为安全存储的密钥）
  static const String secretKey = 'OncePower32BytesKey_1234567890!!';
  // 固定16字节IV（实际若需随机IV，需调整存储逻辑）
  // static final IV iv = IV.fromLength(16);

  // 加密预设列表，返回完整文件字节（含头标识+加密数据）
  static Uint8List encryptPresets(List<AdvancePreset> presets) {
    // 1. 生成头标识字节
    final headerBytes = utf8.encode(header);

    // 2. 数据序列化
    final dataToEncrypt = presets.map((item) => item.toJson()).toList();
    final plainText = jsonEncode(dataToEncrypt);

    // 3. 生成随机IV (更安全)
    final iv = IV.fromSecureRandom(16);
    final ivBytes = iv.bytes;

    // 4. 加密
    final key = Key.fromUtf8(secretKey);
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(plainText, iv: iv);

    // 5. 拼接头+IV+加密数据
    return Uint8List.fromList([
      ...headerBytes,
      ...ivBytes, // 存储IV
      ...encrypted.bytes
    ]);
  }

  static List<AdvancePreset> decryptPresets(Uint8List fileBytes) {
    try {
      // 1. 校验头标识
      final headerLength = utf8.encode(header).length;
      if (fileBytes.length < headerLength + 16) {
        // +16 for IV
        throw Exception(S.current.importPresetErrorDesc1);
      }

      final fileHeader = fileBytes.sublist(0, headerLength);
      final expectedHeaderBytes = utf8.encode(header);
      if (!listEquals(fileHeader, expectedHeaderBytes)) {
        throw Exception(S.current.importPresetErrorDesc2);
      }

      // 2. 提取IV
      final ivBytes = fileBytes.sublist(headerLength, headerLength + 16);
      final iv = IV(ivBytes);

      // 3. 提取加密数据
      final encryptedBytes = fileBytes.sublist(headerLength + 16);

      // 4. 解密
      final key = Key.fromUtf8(secretKey);
      final encrypter = Encrypter(AES(key));
      final decryptedText =
          encrypter.decrypt(Encrypted(encryptedBytes), iv: iv);

      // 5. 反序列化
      final List<dynamic> jsonList = jsonDecode(decryptedText);
      return jsonList
          .map((json) => AdvancePreset.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(S.current.importPresetErrorDesc3(e.toString()));
    }
  }
}
