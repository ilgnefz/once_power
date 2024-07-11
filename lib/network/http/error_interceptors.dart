import 'package:dio/dio.dart';

class ErrorInterceptors extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.badResponse:
        errorTip(err, '响应错误');
        break;
      case DioExceptionType.receiveTimeout:
        errorTip(err, '接收超时');
        break;
      case DioExceptionType.sendTimeout:
        errorTip(err, '发送超时');
        break;
      case DioExceptionType.connectionTimeout:
        errorTip(err, '连接超时');
        break;
      case DioExceptionType.cancel:
        errorTip(err, '连接已取消');
        break;
      case DioExceptionType.badCertificate:
        errorTip(err, '证书错误');
        break;
      case DioExceptionType.connectionError:
        errorTip(err, '连接错误');
        break;
      case DioExceptionType.unknown:
        errorTip(err, '未知错误');
        break;
      default:
        errorTip(err, '其他错误');
    }

    if (err.response != null && err.response?.data != null) {
      print(err.response?.data);
      // AppToast.showToast(err.response?.data['message']);
    }
  }
}

errorTip(DioError err, String message) {
  print('-------------------- ERROR --------------------');
  print('type: ${err.type}');
  print('type: ${err.response}');
  print('type: ${err.error}');
  print('type: ${err.requestOptions}');
  print('type: ${err.message}');
  print('--------------------  END  --------------------');
}
