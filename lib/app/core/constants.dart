abstract class Strings {
  static const String version = '0.1.0+1';

  static const String executableName = 'assist';

  static const String appName = 'Assist';

  static const String description = 'Manage your Dart/Flutter projects easily.';

  static String repositoryUrl = 'https://github.com/salah-rashad/assist';

  static const String logoArt = r'''
 _____         _     _
|  _  |___ ___|_|___| |_
|     |_ -|_ -| |_ -|  _|
|__|__|___|___|_|___|_|''';

  static const String logoArt2 = r'''
╭─────╮       ╭─╮   ╭─╮
│  ─  ├───┬───┤─├───┤ ╰─╮
│  │  │⎽ ⎺│⎽ ⎺│ │⎽ ⎺│ ╭─╯  
╰──┴──┴───┴───┴─┴───┴─╯''';

  static String logoArtWithVersion() => '$logoArt   v$version';
}
