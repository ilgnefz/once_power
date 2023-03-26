class ErrorMessage {
  String fileName;
  String reason;
  DateTime time;

  ErrorMessage({
    required this.fileName,
    required this.reason,
    required this.time,
  });
  @override
  String toString() {
    return 'ErrorMessage(fileName: $fileName, reason: $reason, time: $time)';
  }
}
