part of 'cli.runner.dart';

Theme get _customTheme {
  final t = Theme.defaultTheme;
  return t.copyWith(
    showActiveCursor: false,
    symbols: t.symbols.copyWith(section: '│'),
    colors: t.colors.copyWith(
      success: (p0) => p0.brightGreen,
      error: (p0) => p0.indianRed,
    ),
    loaderTheme: t.loaderTheme.copyWith(
      successStyle: (p0) => p0.brightGreen,
      errorStyle: (p0) => p0.indianRed,
    ),
  );
}
