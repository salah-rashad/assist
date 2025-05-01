abstract class RouteNames {
  static const String dashboard = 'dashboard';
  static const String settings = 'settings';

  // Quick actions
  static const String createProject = 'create-project';
  static const String bumpVersion = 'bump-version';
  static const String publishPackage = 'publish-package';

  static String toTitleCase(String input) {
    return input
        .split('-') // split by hyphens
        .map(
          (word) =>
              word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '',
        )
        .join(' ');
  }
}
