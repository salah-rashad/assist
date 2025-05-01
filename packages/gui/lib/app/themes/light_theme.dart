part of 'app_theme.dart';

final class LightTheme extends AppTheme {
  @override
  Brightness get brightness => Brightness.light;

  @override
  ShadColorScheme get colorScheme => ShadBlueColorScheme.light(
    // foreground: Color(0xFF131613),
    // background: Color(0xFFffffff),
    // primary: Color(0xFF0950c3),
    // primaryForeground: Color(0xFFffffff),
    // secondary: Color(0xFFc5d0e2),
    // secondaryForeground: Color(0xFF131613),
    // accent: Color(0xFF457cd3),
    // accentForeground: Color(0xFF131613),
    // destructive: Color(0xffB3261E),
    // destructiveForeground: Color(0xffFFFFFF),
  );

  @override
  ExtendedColors get extendedColors => ExtendedColors(
    success: const Color(0xff00E200),
    warning: const Color(0xFFE3A702),
    info: const Color(0xFF2196F3),
  );
}
