import 'package:assist/app/utils/cli.extensions.dart';
import 'package:promptly/promptly.dart';

/// Get the current theme
Theme get theme => console.theme;

/// Convert bytes to megabytes
String toMegaBytes(int bytes, {int fractionDigits = 2}) {
  return (bytes / (1024 * 1024)).toStringAsFixed(fractionDigits);
}

/// Generate a formatted choice line
String generateChoice(
  String name, [
  String? description,
  bool isDefault = false,
]) {
  final sb = StringBuffer();
  final star = (isDefault ? ' * ' : '');
  String choice = (name + star);
  if (description != null) {
    choice = choice.padRight(20);
  }
  sb.write(choice);
  if (description != null) {
    sb.write(description.truncateChoiceDescription(choice.length));
  }
  String line = sb.toString();
  line = line;
  return line;
}

/// Generate an interactive link line
String linkLine(String uri, [String? label]) {
  const leading = '\x1B]8;;';
  const trailing = '\x1B\\';

  label ??= uri;
  return '$leading$uri$trailing$label$leading$trailing';
}
