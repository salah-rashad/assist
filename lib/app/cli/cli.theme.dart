part of 'cli.runner.dart';

class CliThemes {
  static Theme defaultTheme = _default;

  static Theme get _default {
    final t = Theme.defaultTheme;
    return t.copyWith(
      symbols: t.symbols.copyWith(section: '│'),
      colors: ThemeColors(
        text: (x) => x.gray,
        info: (x) => x.brightBlue,
        error: (x) => x.indianRed,
        warning: (x) => x.yellow,
        success: (x) => x.brightGreen,
        active: (x) => x.brightGreen,
        inactive: (x) => x.gray,
        prefix: (x) => x.gray,
        value: (x) => x.gray,
        hint: (x) => x.lightGray.dim,
      ),
      loaderTheme: t.loaderTheme.copyWith(
        successStyle: (x) => x.brightGreen,
        errorStyle: (x) => x.indianRed,
      ),
      promptTheme: t.promptTheme.copyWith(
        messageStyle: (x) => x.whiteSmoke.bold,
        errorStyle: (x) => x.indianRed,
      ),
    );
  }
}
