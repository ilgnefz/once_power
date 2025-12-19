class AMapReverseGeo {
  final String status;
  final String info;
  final String infocode;
  final Regeocode? regeocode;

  AMapReverseGeo({
    required this.status,
    required this.info,
    required this.infocode,
    this.regeocode,
  });

  factory AMapReverseGeo.fromJson(Map<String, dynamic> json) {
    return AMapReverseGeo(
      status: json['status'] as String? ?? '0',
      info: json['info'] as String? ?? '',
      infocode: json['infocode'] as String? ?? '',
      regeocode: json['regeocode'] != null
          ? Regeocode.fromJson(json['regeocode'] as Map<String, dynamic>)
          : null,
    );
  }

  String get formattedAddress => regeocode?.formattedAddress ?? '';

  @override
  String toString() {
    return 'AMapReverseGeo{status: $status, info: $info, infocode: $infocode, regeocode: $regeocode}';
  }
}

class Regeocode {
  final String formattedAddress;

  Regeocode({
    required this.formattedAddress,
  });

  factory Regeocode.fromJson(Map<String, dynamic> json) {
    return Regeocode(
      formattedAddress: json['formattedAddress'] as String? ??
          json['formatted_address'] as String? ??
          '',
    );
  }

  @override
  String toString() {
    return 'Regeocode{formattedAddress: $formattedAddress}';
  }
}
