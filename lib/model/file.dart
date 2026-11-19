class FileInfo({
  required final String id,
  required var String name,
  required var String newName,
  required var String extension,
  required var String newExtension,
  required var String folder,
  required var String path,
  var bool checked = true,
}) {
  @override
  String toString() {
    return 'FileInfo(id: $id, name: $name, newName: $newName, extension: $extension, '
        'newExtension: $newExtension, folder: $folder, path: $path, checked: $checked)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is FileInfo && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
