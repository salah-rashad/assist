abstract class Strings {
  static const String version = '0.1.0';

  static const String executableName = 'assist';

  static const String appName = 'Pub Assist';

  static const String description = 'Manage your Dart/Flutter packages easily.';

  static String repositoryUrl = 'https://github.com/salah-rashad/assist';

  static const String logoArt = r'''
 _____     _      _____         _     _
|  _  |_ _| |_   |  _  |___ ___|_|___| |_
|   __| | | . |  |     |_ -|_ -| |_ -|  _|
|__|  |___|___|  |__|__|___|___|_|___|_|''';

  static const String logoArt2 = r'''
╭─────╮   ╭─╮    ╭─────╮       ╭─╮   ╭─╮
│  ─  ├─┬─┤ ╰─╮  │  ─  ├───┬───┤─├───┤ ╰─╮
│  ╭──┤ │ │ │ │  │  │  │⎽ ⎺│⎽ ⎺│ │⎽ ⎺│ ╭─╯  
╰──╯  ╰───┴───╯  ╰──┴──┴───┴───┴─┴───┴─╯''';

  static String logoArtWithVersion() => '$logoArt   v$version';
}
