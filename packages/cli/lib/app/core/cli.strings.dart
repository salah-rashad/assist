import 'package:assist_core/constants/version.dart';

abstract class CliStrings {
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

  static String logoArtWithVersion() => '$logoArt   v$assistVersion';
}
