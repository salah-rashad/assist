part of 'app_theme.dart';

final class DarkTheme extends AppTheme {
  @override
  Brightness get brightness => Brightness.dark;

  @override
  ShadColorScheme get colorScheme => ShadBlueColorScheme.dark(
      // background: Color(0xFF17191d),
      // card: Color(0xFF1f232a),
      // cardForeground: Color(0xFFC9D1D9),
      // foreground: Color(0xFFC9D1D9),
      // primary: Color(0xFFC9D1D9),
      // secondary: Color(0xFFC9D1D9),
      // accent: Color(0xFFC9D1D9),
      // accentForeground: Color(0xFF15151E),

      // foreground: Color(0xFFC9D1D9),
      // background: Color(0xFF000000),
      // primary: Color(0xFF3c83f6),
      // primaryForeground: Color(0xFF000000),
      // secondary: Color(0xFF1d283a),
      // secondaryForeground: Color(0xFFe9ece9),
      // accent: Color(0xFF2c62ba),
      // accentForeground: Color(0xFFe9ece9),
      // destructive: Color(0xffF2B8B5),
      // destructiveForeground: Color(0xff601410),
      // card: Color(0xFF080808),
      );

  @override
  ExtendedColors get extendedColors => ExtendedColors(
        success: const Color(0xFF67c75f),
        warning: const Color(0xFFFFC107),
        info: const Color(0xFF2196F3),
      );
}
