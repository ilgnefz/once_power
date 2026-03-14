import 'dart:convert';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:encrypt/encrypt.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/model/advance.dart';

class PresetEncryptor {
  // 自定义文件后缀
  static const String extension = 'oprt';
  // 自定义文件mimeTyp
  static const String mimeType = 'application/vnd.oncepower.preset+$extension';
  // 固定头标识
  static const String header = 'ONCE_PRESET_V1';
  // 固定32字节密钥
  static const String secretKey = 'OncePower32BytesKey_1234567890!!';

  // Base64字符集
  static const String _base64Chars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

  // 自定义编码表 - 将Base64字符映射为可打印的乱码字符
  // 这样Base64字符串会变成看起来像随机文本的格式
  static const String _customEncodeChars =
      'QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm7894561230+/';

  /// 加密预设列表，返回可读的乱码格式字符串
  static String encryptPresets(List<AdvancePreset> presets) {
    // 1. 数据序列化为JSON
    final dataToEncrypt = presets.map((item) => item.toJson()).toList();
    final String plainText = jsonEncode(dataToEncrypt);

    // 2. 生成随机IV
    final IV iv = IV.fromSecureRandom(16);

    // 3. AES加密
    final Key key = Key.fromUtf8(secretKey);
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(plainText, iv: iv);

    // 4. 组合：头标识 + IV + 加密数据，然后Base64编码
    final combined = '${_encodeHeader(iv)}${encrypted.base64}';

    // 5. 使用自定义编码表转换，生成可读乱码
    return _toCustomEncoding(combined);
  }

  /// 解密预设列表，支持乱码格式字符串
  static List<AdvancePreset> decryptPresets(String encodedText) {
    try {
      // 1. 从自定义编码还原为Base64
      final base64String = _fromCustomEncoding(encodedText.trim());

      // 2. 解码头标识和IV
      final headerInfo = _decodeHeader(base64String);
      if (headerInfo == null) {
        throw Exception(tr(AppL10n.errImportError2));
      }

      // 3. 提取加密数据并解密
      final encryptedPart = base64String.substring(headerInfo.headerLength);
      final key = Key.fromUtf8(secretKey);
      final encrypter = Encrypter(AES(key));
      final decryptedText = encrypter.decrypt64(
        encryptedPart,
        iv: headerInfo.iv,
      );

      // 4. 反序列化
      final List<dynamic> jsonList = jsonDecode(decryptedText);
      return jsonList
          .map((json) => AdvancePreset.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(tr(AppL10n.errImportError3, namedArgs: {"err": "$e"}));
    }
  }

  /// 编码头标识和IV为字符串
  static String _encodeHeader(IV iv) {
    final headerBytes = utf8.encode(header);
    final ivBase64 = base64Encode(iv.bytes);
    final headerBase64 = base64Encode(headerBytes);
    return '$headerBase64.$ivBase64.';
  }

  /// 解码头标识和IV
  static _HeaderInfo? _decodeHeader(String base64String) {
    try {
      // 查找第一个点号分隔符
      final firstDot = base64String.indexOf('.');
      if (firstDot == -1) return null;

      final secondDot = base64String.indexOf('.', firstDot + 1);
      if (secondDot == -1) return null;

      final headerBase64 = base64String.substring(0, firstDot);
      final ivBase64 = base64String.substring(firstDot + 1, secondDot);

      final headerBytes = base64Decode(headerBase64);
      final decodedHeader = utf8.decode(headerBytes);

      if (decodedHeader != header) return null;

      final ivBytes = base64Decode(ivBase64);
      final iv = IV(Uint8List.fromList(ivBytes));

      return _HeaderInfo(iv: iv, headerLength: secondDot + 1);
    } catch (e) {
      return null;
    }
  }

  /// 将Base64字符串转换为自定义编码（可读乱码）
  static String _toCustomEncoding(String base64String) {
    final buffer = StringBuffer();
    for (int i = 0; i < base64String.length; i++) {
      final char = base64String[i];
      final index = _base64Chars.indexOf(char);
      if (index != -1) {
        buffer.write(_customEncodeChars[index]);
      } else {
        buffer.write(char);
      }
    }
    return buffer.toString();
  }

  /// 从自定义编码还原为Base64字符串
  static String _fromCustomEncoding(String customString) {
    final buffer = StringBuffer();
    for (int i = 0; i < customString.length; i++) {
      final char = customString[i];
      final index = _customEncodeChars.indexOf(char);
      if (index != -1) {
        buffer.write(_base64Chars[index]);
      } else {
        buffer.write(char);
      }
    }
    return buffer.toString();
  }
}

class _HeaderInfo {
  final IV iv;
  final int headerLength;

  _HeaderInfo({required this.iv, required this.headerLength});
}
