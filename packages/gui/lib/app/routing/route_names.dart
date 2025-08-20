abstract class RouteNames {
  static const String dashboard = 'dashboard';
  static const String settings = 'settings';

  // Quick actions
  static const String createProject = 'create-project';
  static const String bumpVersion = 'bump-version';
  static const String publishPackage = 'publish-package';
  static const String githubWorkflows = 'github-workflows';
  static const String editChangelog = 'edit-changelog';
  static const String editPubspec = 'edit-pubspec';
  static const String githubServices = 'github-services';

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
