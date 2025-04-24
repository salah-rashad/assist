import 'dart:math' as math;

import 'package:assist/app/utils/string_colors.dart';
import 'package:meta/meta.dart';
import 'package:promptly/promptly.dart';

import '../../utils/helpers.dart';

String _style(String s, StyleFunction? style) => style?.call(s) ?? s;

/// Abstract class representing a command task.
abstract class CommandTask<T> {
  // Success and failure tags
  final String successTag = '[Success]';
  final String failedTag = '[Failed]';

  // Optional success and failure messages
  String? get successHint => null;

  String? get failedHint => null;

  /// The prompt message for the task.
  String get prompt;

  /// Indicating whether to clear the console after execution.
  bool get clear => false;

  /// Method to execute the task. Must be overridden by subclasses.
  @mustCallSuper
  @protected
  Future<T?> execute(LoaderState state);

  /// Runs the task with optional parameters for customization.
  Future<T?> run({
    bool? clear,
    bool? throwOnError,
    Function(Object)? onError,
    StyleFunction? prompt,
    StyleFunction? successHint,
    StyleFunction? failedHint,
    StyleFunction? successTag,
    StyleFunction? failedTag,
  }) async {
    // Apply custom styles
    final sPrompt = _style(this.prompt, prompt);
    final sSuccessHint = _style(this.successHint?.cGray ?? '', successHint);
    final sFailedHint = _style(this.failedHint?.cGray ?? '', failedHint);
    final sSuccessTag = _style(this.successTag.dim(), successTag);
    final sFailedTag = _style(this.failedTag.dim(), failedTag);

    T? result;

    await task(
      sPrompt,
      successMessage: _buildSuccessMsg(sPrompt, sSuccessHint, sSuccessTag),
      failedMessage: _buildFailedMsg(sPrompt, sFailedHint, sFailedTag),
      clear: clear ?? this.clear,
      throwOnError: throwOnError ?? false,
      onError: onError,
      task: (state) async {
        result = await execute(state);
      },
    );

    return result;
  }

  /// Formats a string with the console's prefix line style.
  String _m(String s) => theme.prefixLine(s);

  /// Constructs the success message.
  String _buildSuccessMsg(String prompt, String? hint, String tag) {
    tag = '  $tag';
    final padWidth = math.min(
      -console.spacing - tag.strip().length + 80,
      -console.spacing - tag.strip().length + console.windowWidth,
    );

    final sb = StringBuffer();
    sb.write(prompt.padRight(padWidth)); // Aligns the prompt
    sb.write(tag); // Adds the success tag

    if (hint != null) {
      sb.writeln();
      sb.write(_m(hint));
    }
    return sb.toString();
  }

  /// Constructs the failure message.
  String _buildFailedMsg(String prompt, String? hint, String tag) {
    tag = '  $tag';
    final padWidth = math.min(
      -console.spacing - tag.strip().length + 80,
      -console.spacing - tag.strip().length + console.windowWidth,
    );

    final sb = StringBuffer();
    sb.write(prompt.padRight(padWidth)); // Aligns the prompt
    sb.write(tag); // Adds the failure tag

    if (hint != null) {
      sb.writeln();
      sb.write(_m(hint));
    }
    return sb.toString();
  }
}
