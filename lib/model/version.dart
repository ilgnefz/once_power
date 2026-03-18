class VersionInfoRes {
  List<VersionInfo> info;

  VersionInfoRes({required this.info});

  factory VersionInfoRes.fromJson(Map<String, dynamic> json) => VersionInfoRes(
    info: List<VersionInfo>.from(
      json["info"].map((x) => VersionInfo.fromJson(x)),
    ),
  );

  @override
  String toString() => 'VersionInfoRes{info: $info}';
}

class VersionInfo {
  String version;
  List<String> description;

  VersionInfo({required this.version, required this.description});

  factory VersionInfo.fromJson(Map<String, dynamic> json) => VersionInfo(
    version: json["version"],
    description: List<String>.from(json["description"].map((x) => x)),
  );

  @override
  String toString() {
    return 'VersionInfo{version: $version, description: $description}';
  }
}
