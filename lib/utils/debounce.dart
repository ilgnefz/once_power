import 'dart:async';
import 'dart:ui';

/// 通用防抖工具类
/// 用于限制函数在短时间内的重复调用，提高性能和用户体验
class Debounce {
  /// 防抖定时器 - 静态字段，确保全局唯一性
  static Timer? _timer;
  
  /// 固定的防抖延迟时间为100毫秒
  static const Duration _fixedDelay = Duration(milliseconds: 100);
  
  /// 私有构造函数，防止实例化
  Debounce._();
  
  /// 执行防抖函数 - 静态方法
  /// [action] 需要防抖的操作函数
  static void run(VoidCallback action) {
    // 取消之前的定时器
    cancel();
    
    // 设置新的定时器，固定100毫秒延迟
    _timer = Timer(_fixedDelay, action);
  }
  
  /// 取消当前定时器 - 静态方法
  static void cancel() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }
}
