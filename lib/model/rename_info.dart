class RenameInfo {
  String file;
  String message;

  RenameInfo({
    required this.file,
    required this.message,
  });

  @override
  String toString() => 'RenameInfo{file: $file, message: $message}';
}
