import 'package:assist_gui/app/themes/theme_extenstions/extended_colors.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

part 'dark_theme.dart';
part 'light_theme.dart';

sealed class AppTheme {
  Brightness get brightness;

  ShadColorScheme get colorScheme;

  ExtendedColors get extendedColors;

  static AppTheme get light => LightTheme();

  static AppTheme get dark => DarkTheme();

  bool get isDark => brightness == Brightness.dark;

  static AppTheme of(BuildContext context) =>
      ShadTheme.of(context).brightness == Brightness.dark ? dark : light;

  ShadThemeData themeData() => ShadThemeData(
        extensions: [extendedColors],
        brightness: brightness,
        colorScheme: colorScheme,
        radius: BorderRadius.all(Radius.circular(12)),
        inputTheme: ShadInputTheme(
          decoration: ShadDecoration(
            color: colorScheme.mutedForeground.withValues(alpha: 0.1),
          ),
        ),
        ghostButtonTheme: ShadButtonTheme(
          hoverBackgroundColor:
              colorScheme.mutedForeground.withValues(alpha: 0.1),
        ),
        tooltipTheme: ShadTooltipTheme(
          decoration: ShadDecoration(
              color: colorScheme.secondary,
              border: ShadBorder.all(
                radius: BorderRadius.all(Radius.circular(8)),
                padding: EdgeInsets.zero,
                color: colorScheme.mutedForeground,
                width: 1,
              ),
              shadows: [
                BoxShadow(
                  blurRadius: 3,
                  color: colorScheme.foreground.withValues(alpha: 0.1),
                  offset: Offset(0, 2),
                ),
              ]),
        ),
        // secondaryButtonTheme: ShadButtonTheme(
        //   hoverBackgroundColor: colorScheme.secondaryForeground.withValues(
        //     alpha: 0.1,
        //   ),
        // ),
        // decoration: ShadDecoration(
        //   color: colorScheme.mutedForeground.withValues(alpha: 0.3),
        // ),
      );

  ThemeData materialThemeData() =>
      ThemeData(scaffoldBackgroundColor: Colors.transparent);
}
