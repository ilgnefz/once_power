import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/utils/storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'error_interceptors.dart';

const String baseUrl = 'https://api.themoviedb.org/3';

class HttpUtil {
  factory HttpUtil() => _instance;
  static final HttpUtil _instance = HttpUtil._internal();

  late Dio dio;
  CancelToken cancelToken = CancelToken();

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 5),
      // headers: {'Content-Type': 'application/json'},
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );

    dio = Dio(options);
    dio.interceptors.add(PrettyDioLogger());
    dio.interceptors.add(ErrorInterceptors());

    CookieJar cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    final cacheOptions = CacheOptions(
      store: MemCacheStore(),
      policy: CachePolicy.request,
      hitCacheOnErrorExcept: [401, 403],
      maxStale: const Duration(days: 7),
      priority: CachePriority.normal,
      cipher: null,
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      allowPostMethod: false,
    );

    dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));
  }

  void cancelRequest() {
    cancelToken.cancel('cancelled');
  }

  Map<String, String>? getAuthorization() {
    Map<String, String>? headers;
    String? accessToken = StorageUtil.getString(AppKeys.apiKey);
    if (accessToken != null) {
      headers = {
        'accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };
    }
    return headers;
  }

  Future get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onReceiveProgress,
  }) async {
    Options requestOptions = options ?? Options();
    Map<String, String>? authorization = getAuthorization();
    if (authorization != null) {
      requestOptions = requestOptions.copyWith(headers: authorization);
    }
    Response response = await dio.get(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
    return response.data;
  }
}
