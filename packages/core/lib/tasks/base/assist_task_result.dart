class AssistTaskResult {
  final bool success;
  final String? message;

  const AssistTaskResult({
    required this.success,
    this.message,
  });

  factory AssistTaskResult.error([String? message]) =>
      AssistTaskResult(success: false, message: message);

  factory AssistTaskResult.success([String? message]) =>
      AssistTaskResult(success: true, message: message);
}
