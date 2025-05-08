import 'package:assist_core/constants/strings.dart';

class Env {
  /// The current working directory
  static String pwd = const String.fromEnvironment(EnvVarKeys.pwd);
}
