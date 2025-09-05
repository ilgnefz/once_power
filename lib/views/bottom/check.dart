import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/config/theme/bottom_text.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/widgets/common/text_btn.dart';

class CheckBtn extends ConsumerStatefulWidget {
  const CheckBtn({super.key});

  @override
  ConsumerState<CheckBtn> createState() => _CheckBtnState();
}

class _CheckBtnState extends ConsumerState<CheckBtn> {
  bool check = false;

  Future<void> checkVersion() async {
    setState(() => check = true);
    await Future.delayed(Duration(seconds: 10));
    // check = true;
    // setState(() {});
    // NotificationInfo notification = NotificationInfo();
    // try {
    //   Dio dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 5)));
    //   final response = await dio.get(AppText.versionUrl);
    //   VersionInfoRes res =
    //   VersionInfoRes.fromJson(jsonDecode(response.toString()));
    //   Log.i(res.toString());
    //   String version = res.info.first.version;
    //   int currentVersion = formatVersionNum(PackInfo.getVersion());
    //   List<String> desc = res.info.first.description;
    //   if (formatVersionNum(version) > currentVersion) {
    //     notification.title = S.current.checkCompleted;
    //     notification.message = S.current.newVersionInfo(version);
    //     notification.detailList = desc.map((e) {
    //       int index = desc.indexOf(e);
    //       index = desc.length > 1 ? index + 1 : 0;
    //       return InfoDetail(file: '', message: index == 0 ? e : '$index. $e');
    //     }).toList();
    //     notification.time = 15;
    //     ref.read(hasNewVersionProvider.notifier).update(true);
    //   } else {
    //     notification.title = S.current.checkCompleted;
    //     notification.message = S.current.noNewVersionInfo;
    //   }
    // } catch (e) {
    //   notification.type = NotificationType.error;
    //   notification.title = S.current.checkFailed;
    //   notification.message = e.toString();
    // }
    // notification.show();
    // check = false;
    // setState(() {});
    setState(() => check = false);
  }

  @override
  Widget build(BuildContext context) {
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
    return TextBtn(tr(AppL10n.bottomCheck), onPressed: checkVersion);
  }
}
