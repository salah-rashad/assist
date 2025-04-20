import 'package:assist/main.dart';

void main(List<String> args) {
  runApp(args);
}

// // Capture the current working directory of the Dart/Flutter project
// late final String projectDir;
//
// void main(List<String> args) async {
//   _initializeProjectDir(args.firstOrNull);
//   _welcomeMessage();
//   _checkPubspecExists();
//   final process = await _launchFlutterApp();
//   await _handleExitCode(process.exitCode);
//   print('Flutter app launched successfully!');
// }
//
// void _initializeProjectDir(String? argument) {
//   // get the current working directory from the arguments
//   final cwd = argument;
//
//   if (cwd != null) {
//     projectDir = cwd;
//   } else {
//     projectDir = Directory.current.path;
//   }
// }
//
// void _welcomeMessage() {
//   print(
//     '''
//
// ${chalk.white.bold(r'''
//
//
//  _____     _      _____         _     _
// |  _  |_ _| |_   |  _  |___ ___|_|___| |_
// |   __| | | . |  |     |_ -|_ -| |_ -|  _|
// |__|  |___|___|  |__|__|___|___|_|___|_|
//
//
//
// ''')}
// ${chalk.white.onIndigo.bold('Welcome to Assist! 🚀')}
// ${chalk.gray('''
// This is a tool that helps you manage your Dart/Flutter packages easily
// with a user-friendly interface.
//
// For more information, visit https://github.com/salah-rashad/assist
// --------------------------------------------
// ''')}
// Launching at:
//     ${chalk.green.bold.italic(projectDir)}
//
// ''',
//   );
// }
//
// /// Check if `pubspec.yaml` exists in the current directory
// void _checkPubspecExists() {
//   // 2. Check if `pubspec.yaml` exists in the current directory
//   final pubspecFile = File(path.join(projectDir, 'pubspec.yaml'));
//
//   if (pubspecFile.existsSync()) {
//     // printCheckSuccess('`pubspec.yaml` file found!');
//   } else {
//     printError(
//       'Error: No `pubspec.yaml` file found in the launching directory!',
//     );
//     exit(1); // Exit with a non-zero status code (indicating an error)
//   }
// }
//
// /// Proceed to launch the Flutter desktop app from the `gui/` folder
// ///
// /// Pass the project directory as a `--dart-define` argument
// Future<Process> _launchFlutterApp() async {
//   final process = await Process.start(
//     'flutter',
//     [
//       'run',
//       '--release',
//       _platformTarget(), // Detect platform (macOS, Windows, Linux)
//       '--dart-define=PROJECT_DIR=$projectDir', // Pass project directory
//     ],
//     runInShell: true,
//     workingDirectory: 'gui', // Start the Flutter app in the `gui/` folder
//   );
//
//   // 4. Stream the output of the Flutter process to the console
//   await stdout.addStream(process.stdout);
//   await stderr.addStream(process.stderr);
//
//   return process;
// }
//
// /// Handle the exit code of the Flutter process
// Future<void> _handleExitCode(Future<int> code) async {
//   final exitCode = await code;
//   if (exitCode != 0) {
//     print('Flutter process failed with exit code $exitCode');
//     exit(exitCode); // Exit with the same code that the Flutter process used
//   }
// }
//
// // Helper function to detect the platform (macOS, Windows, or Linux)
// // This is necessary to specify which Flutter desktop platform to run
// String _platformTarget() {
//   if (Platform.isMacOS) return 'macos';
//   if (Platform.isWindows) return 'windows';
//   if (Platform.isLinux) return 'linux';
//
//   // If the platform is unsupported, throw an error
//   throw UnsupportedError('Unsupported OS: ${Platform.operatingSystem}');
// }
