import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/network/http/http.dart';
import 'package:once_power/utils/utils.dart';

class MoviesAPI {
  static search(String keyword) async {
    Locale? cacheLocale = StorageUtil.getLocale(AppKeys.locale);
    String language = 'en_US';
    if (cacheLocale?.languageCode == 'zh') language = 'zh_CN';
    Response response = await HttpUtil().get(
      '/search/movie',
      queryParameters: {
        'query': keyword,
        'language': language,
        'page': 1,
      },
    );
    print(response.data);
  }
}
