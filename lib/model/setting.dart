import 'dart:typed_data';

class _Undefined {
  const _Undefined();
}

const _undefined = _Undefined();

class CustomTheme {
  final bool divider;
  final bool shadow;
  final double alpha;
  final double sigma;
  final String background;
  final Uint8List? backgroundBytes;

  CustomTheme({
    this.divider = false,
    this.shadow = false,
    this.alpha = 0.8,
    this.sigma = 0,
    this.background = '',
    this.backgroundBytes,
  });

  factory CustomTheme.fromJson(Map<String, dynamic> json) {
    final bytes = json['backgroundBytes'];
    return CustomTheme(
      divider: json['divider'] ?? false,
      shadow: json['shadow'] ?? false,
      alpha: json['alpha'] ?? 0.8,
      sigma: json['sigma'] ?? 0.0,
      background: json['background'] ?? '',
      backgroundBytes: bytes != null
          ? Uint8List.fromList(List<int>.from(bytes))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'divider': divider,
      'shadow': shadow,
      'alpha': alpha,
      'sigma': sigma,
      'background': background,
      'backgroundBytes': backgroundBytes?.toList(),
    };
  }

  CustomTheme copyWith({
    bool? divider,
    bool? shadow,
    double? alpha,
    double? sigma,
    String? background,
    Object? backgroundBytes = _undefined,
  }) {
    return CustomTheme(
      divider: divider ?? this.divider,
      shadow: shadow ?? this.shadow,
      alpha: alpha ?? this.alpha,
      sigma: sigma ?? this.sigma,
      background: background ?? this.background,
      backgroundBytes: backgroundBytes == _undefined
          ? this.backgroundBytes
          : backgroundBytes as Uint8List?,
    );
  }

  @override
  String toString() {
    return 'CustomTheme{divider: $divider, shadow: $shadow, alpha: $alpha, sigma: $sigma, background: $background}';
  }
}
