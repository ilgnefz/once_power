import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/model/model.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/utils/utils.dart';

class CheckVersion extends ConsumerStatefulWidget {
  const CheckVersion({super.key});

  @override
  ConsumerState<CheckVersion> createState() => _CheckVersionState();
}

class _CheckVersionState extends ConsumerState<CheckVersion> {
  final String versionUrl =
      'https://gitee.com/ilgnefz/once_power/raw/master/version.json';
  bool hover = false;
  bool check = false;

  void checkVersion() async {
    check = true;
    try {
      Dio dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 5)));
      final response = await dio.get(versionUrl);
      VersionInfoResponse res =
          VersionInfoResponse.fromJson(jsonDecode(response.toString()));
      print(res.toString());
      int version = getExtendedVersionNumber(res.info.first.version);
      int currentVersion = getExtendedVersionNumber(PackageDesc.getVersion());
      List<String> desc = res.info.first.description;
      if (version > currentVersion) {
        NotificationMessage.show(
          '检测完成',
          '新的版本 v${res.info.first.version} 可以更新',
          desc.map((e) {
            int index = desc.indexOf(e);
            index = desc.length > 1 ? index + 1 : 0;
            return NotificationInfo(
                file: index == 0 ? '' : '$index', message: e);
          }).toList(),
          MessageType.success,
          30,
        );
        ref.read(newVersionProvider.notifier).update();
      } else {
        NotificationMessage.show('检测完成', '当前已是最新版本', [], MessageType.success);
      }
    } catch (e) {
      NotificationMessage.show('检测失败', '$e', [], MessageType.failure);
    }
    check = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 80,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.center,
      child: InkWell(
        onHover: (v) {
          hover = v;
          setState(() {});
        },
        onTap: check ? null : checkVersion,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              check ? '检测中' : '检测更新',
              style: TextStyle(
                fontSize: 13,
                color: hover ? Theme.of(context).primaryColor : Colors.grey,
              ),
            ),
            if (check)
              Container(
                margin: const EdgeInsets.only(left: 4),
                width: 12,
                height: 12,
                child: const FittedBox(
                  fit: BoxFit.fill,
                  child: CircularProgressIndicator(strokeWidth: 6),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
