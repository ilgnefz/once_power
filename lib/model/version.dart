class VersionInfoResponse {
  final List<VersionInfo> info;

  VersionInfoResponse({required this.info});

  factory VersionInfoResponse.fromJson(Map<String, dynamic> json) =>
      VersionInfoResponse(
        info: List<VersionInfo>.from(
            json["info"].map((e) => VersionInfo.fromJson(e))).toList(),
      );

  @override
  String toString() {
    return 'VersionInfoResponse{info: $info}';
  }
}

class VersionInfo {
  final String version;
  final List<String> description;

  VersionInfo({required this.version, required this.description});

  factory VersionInfo.fromJson(Map<String, dynamic> json) => VersionInfo(
        version: json["version"],
        description: json["desc"],
      );

  @override
  String toString() {
    return 'VersionInfo{version: $version, description: $description}';
  }
}
