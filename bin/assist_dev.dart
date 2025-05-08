import '../packages/cli/bin/assist.dart' as assist;

// A copy of packages/cli/bin/assist.dart
// This allows us to use assist in development mode
void main(List<String> arguments) async {
  // Set a global flag to indicate we're in dev mode
  const devFlag = '--dev';
  const noDevFlag = '--no-dev';

  if (!arguments.contains(devFlag) && !arguments.contains(noDevFlag)) {
    arguments = [...arguments, devFlag];
  }
  assist.main(arguments);
}
