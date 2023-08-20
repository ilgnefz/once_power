import 'dart:io';

import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:once_power/utils/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image.g.dart';

Future<DateTime?> getExifDate(String filePath) async {
  final fileBytes = File(filePath).readAsBytesSync();
  final data = await readExifFromBytes(fileBytes);
  if (!data.containsKey('Image DateTime')) return null;
  String? dateTime = data['Image DateTime'].toString();
  if (dateTime == '') return null;
  debugPrint('$filePath拍摄日期: ${exifDateFormat(dateTime)}');
  return exifDateFormat(dateTime);
}

@riverpod
class ExifDate extends _$ExifDate {
  @override
  DateTime? build() => null;
  void update(String path) async => state = await getExifDate(path);
}
