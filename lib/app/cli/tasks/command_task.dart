import 'dart:math' as math;

import 'package:chalkdart/chalkstrings.dart';
import 'package:meta/meta.dart';
import 'package:promptly/promptly.dart' hide Tint;

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
    // Default styles
    final sHint = this.successHint?.gray;
    final fHint = this.failedHint?.gray;
    final sTag = this.successTag.dim;
    final fTag = this.failedTag.dim;

    // Apply custom styles
    final prompt_ = prompt?.call(this.prompt) ?? this.prompt;
    final successHint_ = successHint?.call(sHint ?? '') ?? sHint;
    final successTag_ = successTag?.call(sTag) ?? sTag;
    final failedHint_ = failedHint?.call(fHint ?? '') ?? fHint;
    final failedTag_ = failedTag?.call(fTag) ?? fTag;

    T? result;

    await task(
      prompt?.call(this.prompt) ?? this.prompt,
      successMessage: _buildSuccessMsg(prompt_, successHint_, successTag_),
      failedMessage: _buildFailedMsg(prompt_, failedHint_, failedTag_),
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
  String _m(String s) => console.theme.prefixLine(s);

  /// Constructs the success message.
  String _buildSuccessMsg(String prompt, String? hint, String tag) {
    tag = '  $tag';
    final padWidth = math.min(
      -console.spacing - tag.strip.length + 80,
      -console.spacing - tag.strip.length + console.windowWidth,
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
      -console.spacing - tag.strip.length + 80,
      -console.spacing - tag.strip.length + console.windowWidth,
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
