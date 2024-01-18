import 'package:logger/logger.dart';

class Log {
  static final Log _instance = Log._();
  factory Log() => _instance;
  static late Logger _logger;

  Log._();

  static init() => _logger = Logger();

  static void t(String message) {
    _logger.t(message);
  }

  static void d(String message) {
    _logger.d(message);
  }

  static void i(String message) {
    _logger.i(message);
  }

  static void w(String message) {
    _logger.w(message);
  }

  static void e(String message) {
    _logger.e(message);
  }
}
