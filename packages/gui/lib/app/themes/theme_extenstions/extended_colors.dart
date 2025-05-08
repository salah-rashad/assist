import 'package:assist_gui/app/themes/app_theme.dart';
import 'package:flutter/material.dart';

class ExtendedColors extends ThemeExtension<ExtendedColors> {
  const ExtendedColors({
    required this.success,
    required this.warning,
    required this.info,
  });

  factory ExtendedColors.fallback() => LightTheme().extendedColors;

  final Color success;
  final Color warning;
  final Color info;

  @override
  ExtendedColors copyWith({
    Color? success,
    Color? warning,
    Color? info,
    Color? mutedForeground,
  }) {
    return ExtendedColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
    );
  }

  @override
  ExtendedColors lerp(ThemeExtension<ExtendedColors>? other, double t) {
    if (other is! ExtendedColors) return this;
    return ExtendedColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
    );
  }
}
