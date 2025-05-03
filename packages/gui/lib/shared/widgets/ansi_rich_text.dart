import 'package:flutter/material.dart';

class AnsiText extends StatelessWidget {
  const AnsiText(this.ansiString, {super.key, this.style});

  final String ansiString;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: asTextSpan(),
    );
  }

  TextSpan asTextSpan() {
    return TextSpan(
      style: style,
      children: _parseAnsi(ansiString),
    );
  }

  List<TextSpan> _parseAnsi(String input) {
    final regex = RegExp(r'\x1B\[(\d+)(;\d+)*m');
    final matches = regex.allMatches(input);

    List<TextSpan> spans = [];
    int lastIndex = 0;
    TextStyle currentStyle = const TextStyle(color: Colors.white);

    for (final match in matches) {
      if (match.start > lastIndex) {
        spans.add(TextSpan(
          text: input.substring(lastIndex, match.start),
          style: currentStyle,
        ));
      }

      final codes = match.group(0)!;
      currentStyle = _styleFromAnsi(codes);
      lastIndex = match.end;
    }

    if (lastIndex < input.length) {
      spans.add(TextSpan(
        text: input.substring(lastIndex),
        style: currentStyle,
      ));
    }

    return spans;
  }

  TextStyle _styleFromAnsi(String ansiCode) {
    final codeValues = ansiCode
        .replaceAll('\x1B[', '')
        .replaceAll('m', '')
        .split(';')
        .map(int.parse)
        .toList();

    // Basic ANSI 30-37 (foreground), 90-97 (bright)
    const ansiColorMap = {
      30: Colors.black,
      31: Colors.red,
      32: Colors.green,
      33: Colors.yellow,
      34: Colors.blue,
      35: Colors.pink,
      36: Colors.cyan,
      37: Colors.white,
      90: Colors.grey,
      91: Colors.redAccent,
      92: Colors.lightGreen,
      93: Colors.amber,
      94: Colors.lightBlue,
      95: Colors.pinkAccent,
      96: Colors.cyanAccent,
      97: Colors.white,
    };

    Color? color;

    for (final code in codeValues) {
      if (ansiColorMap.containsKey(code)) {
        color = ansiColorMap[code];
      }
    }

    return TextStyle(color: color ?? Colors.white);
  }
}
