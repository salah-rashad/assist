extension DurationExt on Duration {
  String toDurationString() {
    final minutes = inMinutes;
    final seconds = inSeconds;
    final milliseconds = inMilliseconds;

    if (minutes > 0) {
      return '${minutes}m';
    } else if (seconds > 0) {
      return '${seconds}s';
    } else {
      return '${milliseconds}ms';
    }
  }
}
