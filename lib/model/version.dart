class VersionInfo {
  VersionInfo({
    required this.info,
  });

  List<Info> info;

  factory VersionInfo.fromJson(Map<String, dynamic> json) => VersionInfo(
        info: List<Info>.from(json["info"].map((x) => Info.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": List<dynamic>.from(info.map((x) => x.toJson())),
      };
}

class Info {
  Info({
    required this.version,
    required this.desc,
  });

  String version;
  Desc desc;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        version: json["version"],
        desc: Desc.fromJson(json["desc"]),
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "desc": desc.toJson(),
      };
}

class Desc {
  Desc({
    required this.zh,
    required this.en,
  });

  String zh;
  String en;

  factory Desc.fromJson(Map<String, dynamic> json) => Desc(
        zh: json["zh"],
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "zh": zh,
        "en": en,
      };
}
