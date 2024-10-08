import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/notification_info.dart';
import 'package:once_power/model/version.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/views/bottom_bar/download.dart';
import 'package:once_power/widgets/common/notification.dart';
import 'package:once_power/widgets/common/text_btn.dart';

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
    try {
      Dio dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 5)));
      final response = await dio.get(AppText.versionUrl);
      VersionInfoRes res =
          VersionInfoRes.fromJson(jsonDecode(response.toString()));
      Log.i(res.toString());
      int version = getVersionNumber(res.info.first.version);
      int currentVersion = getVersionNumber(PackageDesc.getVersion());
      List<String> desc = res.info.first.description;
      if (version > currentVersion) {
        NotificationMessage.show(SuccessNotification(
            S.current.checkCompleted,
            S.current.newVersionInfo(res.info.first.version),
            desc.map((e) {
              int index = desc.indexOf(e);
              index = desc.length > 1 ? index + 1 : 0;
              return NotificationInfo(
                  file: '', message: index == 0 ? e : '$index. $e');
            }).toList()));
        ref.read(newVersionProvider.notifier).update(true);
      } else {
        NotificationMessage.show(SuccessNotification(
            S.current.checkCompleted, S.current.noNewVersionInfo));
      }
    } catch (e) {
      NotificationMessage.show(
          ErrorNotification(S.current.checkFailed, '$e', []));
    }
    check = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final String checkUpdates = S.of(context).checkUpdate;
    final String checking = S.of(context).checking;
    // final String checkComplete = S.of(context).checkCompleted;

    return ref.watch(newVersionProvider)
        ? const DownloadTextBtn()
        : TextBtn(
            text: check ? checking : checkUpdates,
            onTap: check ? null : checkVersion,
            action: Container(
              margin: const EdgeInsets.only(left: 4),
              width: check ? 12 : 0,
              height: 12,
              child: const FittedBox(
                fit: BoxFit.fill,
                child: CircularProgressIndicator(strokeWidth: 6),
              ),
            ),
          );
  }
}
