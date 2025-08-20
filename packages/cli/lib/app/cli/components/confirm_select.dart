import 'package:promptly/promptly.dart';

bool confirmSelect(
  String prompt, {
  String? yes,
  String? no,
  StyleFunction? promptStyle,
  StyleFunction? yesStyle,
  StyleFunction? noStyle,
  bool? defaultValue,
  int? value,
}) {
  // Defaults
  yes ??= 'Yes';
  no ??= 'No';

  // Apply custom styles
  prompt = promptStyle?.call(prompt) ?? prompt;
  yes = yesStyle?.call(yes) ?? yes;
  no = noStyle?.call(no) ?? no;

  final result = selectOne<String>(
    prompt,
    choices: [yes, no],
    defaultValue: defaultValue == true ? yes : no,
    value: value,
  );

  return result == yes;
}
