import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/config/theme/bottom_text.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/text.dart';
import 'package:once_power/enum/notification.dart';
import 'package:once_power/model/notification.dart';
import 'package:once_power/model/version.dart';
import 'package:once_power/util/format.dart';
import 'package:once_power/util/pack.dart';
import 'package:once_power/widget/bottom/text.dart';

import 'download.dart';

class CheckVersionButton extends ConsumerStatefulWidget {
  const CheckVersionButton({super.key});

  @override
  ConsumerState<CheckVersionButton> createState() => _CheckBtnState();
}

class _CheckBtnState extends ConsumerState<CheckVersionButton> {
  bool check = false;
  bool newVersion = false;

  Future<void> checkVersion() async {
    setState(() => check = true);
    check = true;
    setState(() {});
    NotificationInfo notification = NotificationInfo();
    try {
      Dio dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 5)));
      final response = await dio.get(AppText.versionUrl);
      VersionInfoRes res = VersionInfoRes.fromJson(
        jsonDecode(response.toString()),
      );
      String version = res.info.first.version;
      int currentVersion = formatVersionNum(PackInfo.getVersion());
      List<String> desc = res.info.first.description;
      if (formatVersionNum(version) > currentVersion) {
        notification.title = tr(AppL10n.successCheck);
        notification.message = tr(
          AppL10n.successNewVersion,
          namedArgs: {'version': version},
        );
        notification.detailList = desc.map((e) {
          int index = desc.indexOf(e);
          index = desc.length > 1 ? index + 1 : 0;
          return InfoDetail(file: '', message: index == 0 ? e : '$index. $e');
        }).toList();
        notification.time = 15;
        setState(() => newVersion = true);
      } else {
        notification.title = tr(AppL10n.successCheck);
        notification.message = tr(AppL10n.successNoNewVersion);
      }
    } catch (e) {
      notification.type = NotificationType.error;
      notification.title = tr(AppL10n.errCheck);
      notification.message = e.toString();
    }
    notification.show();
    check = false;
    setState(() {});
    setState(() => check = false);
  }

  @override
  Widget build(BuildContext context) {
    if (newVersion) return const DownloadTextButton();
    if (check) {
      return Row(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            tr(AppL10n.bottomChecking),
            style: Theme.of(context).extension<BottomTextTheme>()?.textStyle,
          ),
          SizedBox(
            width: 12,
            height: 12,
            child: const FittedBox(
              fit: BoxFit.fill,
              child: CircularProgressIndicator(strokeWidth: 6),
            ),
          ),
        ],
      );
    }
    return BottomTextButton(tr(AppL10n.bottomCheck), onPressed: checkVersion);
  }
}
