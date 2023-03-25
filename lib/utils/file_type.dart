import 'package:once_power/model/rename_file.dart';

getFileType(String extension) {
  final image = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];
  final video = ['mp4', 'avi', 'mov', 'wmv', 'flv'];
  final text = ['txt', 'doc', 'docx', 'pdf', 'xlsx', 'md', 'ppt'];
  if (image.contains(extension)) return FileClassify.image;
  if (video.contains(extension)) return FileClassify.video;
  if (text.contains(extension)) return FileClassify.text;
  return FileClassify.other;
}
