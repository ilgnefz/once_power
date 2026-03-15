class ProgressFileInfo {
  final String name;
  final int size;
  final int transferred;

  ProgressFileInfo({
    required this.name,
    required this.size,
    required this.transferred,
  });

  ProgressFileInfo copyWith({int? size, int? transferred}) {
    return ProgressFileInfo(
      name: name,
      size: size ?? this.size,
      transferred: transferred ?? this.transferred,
    );
  }

  @override
  String toString() {
    return 'ProgressFileInfo{name: $name, size: $size, transferred: $transferred}';
  }
}
