/// Base class for command configuration
abstract class CommandConfigBase {
  const CommandConfigBase();

  /// The name of the executable. (e.g. `dart` or `flutter`)
  String get executableName;

  /// The name of the command. (e.g. `create`)
  String get commandName;

  /// The arguments for the command.
  List<String> get args;

  /// The full arguments for the command, including the command name.
  List<String> get fullArgs => [commandName, ...args];

  /// Returns a string representation of the command to be executed.
  String toCommandLineString() {
    return '$executableName $commandName ${args.join(' ')}';
  }

  /// Returns a list representation of the command to be executed.
  List<String> toCommandLineList() {
    return [executableName, commandName, ...args];
  }
}
