import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/network/http/http.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/widgets/click_icon.dart';
import 'package:once_power/widgets/custom_tooltip.dart';
import 'package:tolyui_feedback/tolyui_feedback.dart';

class GetTvInfo extends StatefulWidget {
  const GetTvInfo({super.key});

  @override
  State<GetTvInfo> createState() => _GetTvInfoState();
}

class _GetTvInfoState extends State<GetTvInfo> {
  void getInfo() async {
    String apiKey =
        await DefaultAssetBundle.of(context).loadString(".tmdb_secret");
    StorageUtil.setString(AppKeys.apiKey, apiKey.split('=').last);
    HttpUtil();
    feedback();
  }

  void feedback() async {
    await showDialog(
      context: context,
      builder: (context) => UnconstrainedBox(
        child: Container(
          width: 600,
          height: 450,
          color: Colors.white,
          alignment: Alignment.center,
          child: TextButton(
            // onPressed: () => TVAPI.search('The Boys'),
            onPressed: () async {
              try {
                Dio dio = Dio(BaseOptions(responseType: ResponseType.plain));
                Response response = await dio
                    .get('https://api.52vmy.cn/api/wl/top/movie?type=text');
                String textData = response.data;
                print(textData);
              } catch (e) {
                print(e);
              }
            },
            child: const Text('发送请求'),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String tvSeriesInfo = S.of(context).tvSeriesInfo;

    return CustomTooltip(
      message: tvSeriesInfo,
      textStyle: const TextStyle(fontSize: 13, color: Color(0xFF666666))
          .useSystemChineseFont(),
      placement: Placement.top,
      child: ClickIcon(
        size: 24,
        svg: AppIcons.tv,
        color: Colors.grey,
        onTap: getInfo,
      ),
    );
  }
}
