class RuleTypeValue {
  final String image;
  final String video;
  final String doc;
  final String audio;
  final String folder;
  final String archive;
  final String other;

  RuleTypeValue({
    this.image = '',
    this.video = '',
    this.doc = '',
    this.audio = '',
    this.folder = '',
    this.archive = '',
    this.other = '',
  });

  bool isEmpty() {
    return image.isEmpty &&
        video.isEmpty &&
        doc.isEmpty &&
        audio.isEmpty &&
        folder.isEmpty &&
        archive.isEmpty &&
        other.isEmpty;
  }

  static bool allPropertiesEmpty(RuleTypeValue value) => value.isEmpty();

  @override
  String toString() {
    return 'RuleTypeValue{'
        'image: $image, '
        'video: $video, '
        'doc: $doc, '
        'audio: $audio, '
        'folder: $folder, '
        'archive: $archive, '
        'other: $other}';
  }

  factory RuleTypeValue.fromJson(Map<String, dynamic> json) => RuleTypeValue(
    image: json["image"],
    video: json["video"],
    doc: json["doc"],
    audio: json["audio"],
    folder: json["folder"],
    archive: json["archive"],
    other: json["other"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "video": video,
    "doc": doc,
    "audio": audio,
    "folder": folder,
    "archive": archive,
    "other": other,
  };
}

class RuleType {
  final String name;
  final String key;

  RuleType(this.name, this.key);

  @override
  String toString() {
    return 'RuleTypeValue{name: $name, key: $key}';
  }
}
