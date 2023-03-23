import 'package:once_power/model/my_file.dart';

getFileType(String extension) {
  final image = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];
  final video = ['mp4', 'avi', 'mov', 'wmv', 'flv'];
  final text = ['txt', 'doc', 'docx', 'pdf', 'xlsx', 'md', 'ppt'];
  if (image.contains(extension)) return CustomFileType.image;
  if (video.contains(extension)) return CustomFileType.video;
  if (text.contains(extension)) return CustomFileType.text;
  return CustomFileType.other;
}
