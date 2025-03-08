import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/models/notification.dart';
import 'package:once_power/models/version.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/widgets/bottom_bar/text_btn.dart';

import 'download.dart';

class CheckVersion extends ConsumerStatefulWidget {
  const CheckVersion({super.key});

  @override
  ConsumerState<CheckVersion> createState() => _CheckVersionState();
}

class _CheckVersionState extends ConsumerState<CheckVersion> {
  bool hover = false;
  bool check = false;

  void checkVersion() async {
    check = true;
    setState(() {});
    NotificationInfo notification = NotificationInfo();
    try {
      Dio dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 5)));
      final response = await dio.get(AppText.versionUrl);
      VersionInfoRes res =
          VersionInfoRes.fromJson(jsonDecode(response.toString()));
      Log.i(res.toString());
      String version = res.info.first.version;
      int currentVersion = formatVersionNum(PackInfo.getVersion());
      List<String> desc = res.info.first.description;
      if (formatVersionNum(version) > currentVersion) {
        notification.title = S.current.checkCompleted;
        notification.message = S.current.newVersionInfo(version);
        notification.detailList = desc.map((e) {
          int index = desc.indexOf(e);
          index = desc.length > 1 ? index + 1 : 0;
          return InfoDetail(file: '', message: index == 0 ? e : '$index. $e');
        }).toList();
        notification.time = 15;
        ref.read(hasNewVersionProvider.notifier).update(true);
      } else {
        notification.title = S.current.checkCompleted;
        notification.message = S.current.noNewVersionInfo;
      }
    } catch (e) {
      notification.type = NotificationType.error;
      notification.title = S.current.checkFailed;
      notification.message = e.toString();
    }
    notification.show();
    check = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (ref.watch(hasNewVersionProvider)) return const DownloadTextBtn();
    return TextBtn(
      text: check ? S.of(context).checking : S.of(context).checkUpdate,
      onTap: check ? null : checkVersion,
      action: check
          ? Container(
              margin: const EdgeInsets.only(left: 4),
              width: 12,
              height: 12,
              child: const FittedBox(
                fit: BoxFit.fill,
                child: CircularProgressIndicator(strokeWidth: 6),
              ),
            )
          : null,
    );
  }
}
