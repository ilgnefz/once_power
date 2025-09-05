/// 任务跟踪器，用于跟踪和管理异步任务的状态
class TaskTracker {
  final List<Future<void>> _activeTasks = [];
  final Set<Future<void>> _completedTasks = {};

  /// 获取当前活跃的任务数量
  int get activeTasksCount => _activeTasks.length - _completedTasks.length;

  /// 获取所有活跃的任务
  List<Future<void>> get activeTasks => List.from(_activeTasks);

  /// 添加一个任务到跟踪器
  void addTask(Future<void> task) {
    _activeTasks.add(task);
    // 监听任务完成，标记为已完成
    task
        .then((_) {
          _markTaskAsCompleted(task);
        })
        .catchError((_) {
          _markTaskAsCompleted(task);
        });
  }

  /// 标记任务为已完成
  void _markTaskAsCompleted(Future<void> task) {
    _completedTasks.add(task);
  }

  /// 清理已完成的任务
  void cleanCompletedTasks() {
    _activeTasks.removeWhere((task) => _completedTasks.contains(task));
    _completedTasks.clear();
  }
}
