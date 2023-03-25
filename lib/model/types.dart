enum LoopType {
  no('不使用'),
  all('全部使用'),
  prefix('仅前缀'),
  suffix('仅后缀');

  final String name;
  const LoopType(this.name);
}

enum ModeType {
  general('默认模式'),
  reserved('保留模式'),
  length('长度模式');

  final String name;
  const ModeType(this.name);
}

enum UploadType { prefix, suffix }

enum MessageType { failure, success, warning }
