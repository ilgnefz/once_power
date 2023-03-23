class MyFile {
  String id;
  String name;
  String newName;
  String parent;
  String extension;
  DateTime createDate;
  CustomFileType type;
  bool checked;

  MyFile({
    required this.id,
    required this.name,
    required this.newName,
    required this.parent,
    required this.extension,
    required this.createDate,
    required this.type,
    required this.checked,
  });

  @override
  String toString() {
    return 'MyFile(id: $id, name: $name, newName: $newName, parent: $parent, extension: $extension, createDate: $createDate, type: $type, checked: $checked)';
  }
}

enum CustomFileType {
  image('图片'),
  video('视频'),
  text('文档'),
  folder('文件夹'),
  other('其他');

  final String name;
  const CustomFileType(this.name);
}
