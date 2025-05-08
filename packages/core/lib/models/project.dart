import 'package:assist_core/constants/enums.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

class Project {
  String path;
  Pubspec pubspec;

  Project({required this.path, Pubspec? pubspec})
      : pubspec = pubspec ?? Pubspec(' ');

  bool get isFlutter => pubspec.dependencies.containsKey('flutter');

  bool get isDart => !isFlutter;

  ProjectType get projectType =>
      isFlutter ? ProjectType.flutter : ProjectType.dart;

  Project copyWith({String? path, Pubspec? pubspec}) {
    return Project(path: path ?? this.path, pubspec: pubspec ?? this.pubspec);
  }
}
