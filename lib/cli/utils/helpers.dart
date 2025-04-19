String toMegaBytes(int bytes, {int fractionDigits = 2}) {
  return (bytes / (1024 * 1024)).toStringAsFixed(fractionDigits);
}
