class VersionInfoResponse {
  List<VersionInfo> info;

  VersionInfoResponse({
    required this.info,
  });

  factory VersionInfoResponse.fromJson(Map<String, dynamic> json) =>
      VersionInfoResponse(
        info: List<VersionInfo>.from(
            json["info"].map((x) => VersionInfo.fromJson(x))),
      );

  @override
  String toString() => 'VersionInfoResponse{info: $info}';
}

class VersionInfo {
  String version;
  List<String> description;

  VersionInfo({
    required this.version,
    required this.description,
  });

  factory VersionInfo.fromJson(Map<String, dynamic> json) => VersionInfo(
        version: json["version"],
        description: List<String>.from(json["description"].map((x) => x)),
      );

  @override
  String toString() {
    return 'VersionInfo{version: $version, description: $description}';
  }
}
