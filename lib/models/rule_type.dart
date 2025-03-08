class RuleTypeValue {
  final String image;
  final String video;
  final String doc;
  final String audio;
  final String folder;
  final String zip;
  final String other;

  RuleTypeValue({
    this.image = '',
    this.video = '',
    this.doc = '',
    this.audio = '',
    this.folder = '',
    this.zip = '',
    this.other = '',
  });

  @override
  String toString() {
    return 'RuleTypeValue{image: $image, video: $video, doc: $doc, audio: $audio, folder: $folder, zip: $zip, other: $other}';
  }

  bool isEmpty() {
    return image.isEmpty &&
        video.isEmpty &&
        doc.isEmpty &&
        audio.isEmpty &&
        folder.isEmpty &&
        zip.isEmpty &&
        other.isEmpty;
  }

  factory RuleTypeValue.fromJson(Map<String, dynamic> json) => RuleTypeValue(
        image: json["image"],
        video: json["video"],
        doc: json["doc"],
        audio: json["audio"],
        folder: json["folder"],
        zip: json["zip"],
        other: json["other"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "video": video,
        "doc": doc,
        "audio": audio,
        "folder": folder,
        "zip": zip,
        "other": other,
      };
}
