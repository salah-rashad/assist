import 'dart:io';

import 'package:chalkdart/chalk.dart';
import 'package:path/path.dart' as path;

// Capture the current working directory of the Dart/Flutter project
final projectDir = Directory.current.path;

void main(List<String> args) async {
  _welcomeMessage();
  // _checkPubspecExists();
  // final process = await _launchFlutterApp();
  // await _handleExitCode(process.exitCode);
  // print('Flutter app launched successfully!');
}

void _welcomeMessage() {
  print('''
${chalk.indigo.bold('Welcome to Pub Assist! 🚀')}
This is a tool that helps you manage your 
Dart/Flutter packages easily with a user-friendly interface.

For more information, visit https://github.com/salah-rashad/pub_assist
${chalk.gray('--------------------------------------------')}
Launching at: 
    ${chalk.green.bold.italic(projectDir)}
''');
}

/// Check if `pubspec.yaml` exists in the current directory
void _checkPubspecExists() {
  // 2. Check if `pubspec.yaml` exists in the current directory
  final pubspecFile = File(path.join(projectDir, 'pubspec.yaml'));

  if (!pubspecFile.existsSync()) {
    print('Error: No `pubspec.yaml` file found in the current directory!');
    exit(1); // Exit with a non-zero status code (indicating an error)
  }
}

/// Proceed to launch the Flutter desktop app from the `gui/` folder
///
/// Pass the project directory as a `--dart-define` argument
Future<Process> _launchFlutterApp() async {
  final process = await Process.start(
    'flutter',
    [
      'run',
      '-d',
      _platformTarget(), // Detect platform (macOS, Windows, Linux)
      '--dart-define=PROJECT_DIR=$projectDir', // Pass project directory
    ],
    runInShell: true,
    workingDirectory: 'gui', // Start the Flutter app in the `gui/` folder
  );

  // 4. Stream the output of the Flutter process to the console
  await stdout.addStream(process.stdout);
  await stderr.addStream(process.stderr);

  return process;
}

/// Handle the exit code of the Flutter process
Future<void> _handleExitCode(Future<int> code) async {
  final exitCode = await code;
  if (exitCode != 0) {
    print('Flutter process failed with exit code $exitCode');
    exit(exitCode); // Exit with the same code that the Flutter process used
  }
}

// Helper function to detect the platform (macOS, Windows, or Linux)
// This is necessary to specify which Flutter desktop platform to run
String _platformTarget() {
  if (Platform.isMacOS) return 'macos';
  if (Platform.isWindows) return 'windows';
  if (Platform.isLinux) return 'linux';

  // If the platform is unsupported, throw an error
  throw UnsupportedError('Unsupported OS: ${Platform.operatingSystem}');
}
