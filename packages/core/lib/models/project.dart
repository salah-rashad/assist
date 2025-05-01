import 'package:pubspec_parse/pubspec_parse.dart';

class Project {
  String path;
  Pubspec pubspec;

  Project({required this.path, Pubspec? pubspec})
    : pubspec = pubspec ?? Pubspec(' ');

  Project copyWith({String? path, Pubspec? pubspec}) {
    return Project(path: path ?? this.path, pubspec: pubspec ?? this.pubspec);
  }
}
