import 'dart:convert';

import 'package:assist_core/core/constants/enums.dart';
import 'package:promptly/promptly.dart';

import 'cli.helpers.dart';

extension StreamExtension on Stream<List<int>> {
  Future<void> asLines(void Function(String data) onData) {
    return transform(
      utf8.decoder,
    ).transform(const LineSplitter()).listen(onData).asFuture();
  }

  Future<void> listenVerbose() => asLines((data) {
    writeln(data.gray().prefixLine());
  });

  Future<void> listenErrors() => asLines((data) {
    writeln(data.error());
  });
}

extension StringTruncateExtension on String {
  /// Truncates a line to fit within the console window width
  String truncateLine([int? spacing, String suffix = '…']) {
    spacing ??= console.spacing;
    final windowWidth = console.windowWidth;

    // Join all lines into a single string
    final line = split('\n').join(' ');

    // If the line is longer than the window width, truncate it
    if (line.strip().length > windowWidth - spacing) {
      return '${line.substring(0, windowWidth - spacing)}$suffix';
    }
    return line;
  }

  String truncateChoice() => truncateLine(6);

  String truncateChoiceDescription(int prefixLength) {
    final suffixLink = '… ${linkLine(this, '→'.darkGray())}';
    return truncateLine(prefixLength + 8, suffixLink);
  }
}

extension StringPrefixExtension on String {
  String prefix(String prefix) {
    final sb = StringBuffer();
    sb.write(prefix.padRight(theme.spacing));
    sb.write(this);
    return sb.toString();
  }

  String prefixArrow() => prefix('→');

  String prefixLine() => theme.prefixLine(this);

  String error() => theme.prefixError(theme.colors.error(this));

  String prefixWarning() => theme.prefixWarning(theme.colors.warning(this));

  String prefixInfo() => theme.prefixInfo(theme.colors.info(this));

  String prefixRun() => theme.prefixRun(theme.colors.success(dim()));

  String prefixHeader() => theme.prefixHeaderLine(this);

  String prefixSection() => theme.prefixSectionLine(this);
}

extension ProjectTypeExtension on ProjectType {
  String toChoice(String flutterVersion, String dartVersion) {
    final version = switch (this) {
      ProjectType.flutter => flutterVersion,
      ProjectType.dart => dartVersion,
    };
    return generateChoice(name, version, false);
  }
}

extension DartProjectTemplateExtension on DartProjectTemplate {
  String toChoice() {
    return generateChoice(name, description, isDefault);
  }
}

extension FlutterProjectTemplateExtension on FlutterProjectTemplate {
  String toChoice() {
    return generateChoice(name, description, isDefault);
  }
}

extension AndroidLanguageExtension on AndroidLanguage {
  String toChoice() {
    return generateChoice(name, null, isDefault);
  }
}

/*extension StringExtension on String {
  String toColorizedUsage(ArgParser argParser) {
    final executableName = Strings.executableName;

    const point = '◆';
    const header = '##';

    // Regex for commands
    final commandRegex = RegExp(
      r'(?:\s{2,}|' +
          RegExp.escape(executableName) +
          r'\s+)(?<c>run|install|help)(?:\s{2,}|\b)',
    );
    final optionsRegex = RegExp(
      argParser.options.entries
          .map(
            (e) =>
                '--${e.value.name}${e.value.abbr != null ? '|-${e.value.abbr}' : ''}',
          )
          .join('|'),
    );

    final sectionHeaders = RegExp(
      'Usage:|Recommended Usage:|Global options:|Available commands:',
    );

    String result = replaceAllMapped(commandRegex, (match) {
          final m = match as RegExpMatch;
          final command = m.namedGroup('c');
          final matchedText = m.group(0)!;

          if (command == null) {
            return match.group(0)!;
          }
          return matchedText.replaceAll(command, command.greenBright);
        })
        .replaceAllMapped(
          RegExp(
            executableName +
                r'|(https?:\/\/\S*' +
                RegExp.escape(executableName) +
                r'\S*)',
          ),
          (match) {
            final g0 = match.group(0)!;
            final g1 = match.group(1);

            // match is in a link
            if (g0 == g1) {
              return g0;
            }

            return g0.darkOrange;
          },
        )
        // // Replace all commands after the "AVAILABLE COMMANDS" header
        // .replaceAllMapped(RegExp(argParser.commands.keys.join('|')), (match) {
        //   final command = match.group(0)!;
        //   final int indexOfCommandsStart = match.input.indexOf(
        //     RegExp('AVAILABLE COMMANDS', caseSensitive: false),
        //   );
        //
        //   return match.start >= indexOfCommandsStart
        //       ? chalk.greenBright(command)
        //       : command;
        // })
        // Replace section headers
        .replaceAllMapped(
          sectionHeaders,
          (match) => '$header${match.group(0)!.replaceAll(':', '')}$header',
        )
        // Replace section content
        .replaceAllMapped(
          RegExp('$header(.*?)$header'),
          (match) =>
              '$point${chalk.black.onAntiqueWhite(' ${match.group(0)!.replaceAll(RegExp(r'##'), '').toUpperCase()} ')}\n\b',
        )
        // Replace angle-bracket arguments
        .replaceAllMapped(
          RegExp('<[^>]+>'),
          (match) => chalk.gray.italic(match.group(0)!),
        )
        // Replace [arguments] block
        .replaceAll('[arguments]', chalk.yellow('[arguments]'))
        // Replace all options (with -- or -)
        .replaceAllMapped(
          optionsRegex,
          (match) => chalk.yellow(match.group(0)!),
        )
        // Replace URLs
        .replaceAllMapped(
          RegExp(r'\b((https?|ftp)://|www\.)[^\s/$.?#].\S*\b'),
          (match) => chalk.reset.blueBright.underline(match.group(0)!),
        )
        // Add decorations
        .replaceFirst('', '╭\n')
        .replaceAll('\n', '\n│ ')
        .replaceAll('│ $point', '\r$point–');
    // .replaceFirst(RegExp(r'│(?!.*│)'), '╰');

    final lastIndex = result.lastIndexOf(RegExp(r'│'));
    if (lastIndex != -1) {
      result = result.replaceRange(lastIndex, lastIndex + 1, '╰');
    }

    return result;
  }
}*/
