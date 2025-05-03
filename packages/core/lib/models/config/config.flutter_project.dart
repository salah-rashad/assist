import 'package:assist_core/models/config/config.base.dart';
import 'package:path/path.dart' as p;

class FlutterProjectConfig extends CommandConfigBase {
  const FlutterProjectConfig({
    required this.projectName,
    required this.projectParentDir,
    required this.description,
    required this.organization,
    required this.template,
    required this.isEmptyApp,
    required this.androidLanguage,
    required this.platforms,
    required this.shouldRunPubGet,
    required this.isOfflineMode,
    required this.shouldOverwrite,
  });

  /// Project name, used also as project directory name
  final String projectName;

  /// Project's parent directory path where the project will be created
  final String projectParentDir;

  /// Project description.
  /// - Flag: `--description=...`
  final String description;

  /// Project organization (e.g. com.example)
  /// - Flag: `--org=...`
  final String organization;

  /// Project template name. See: [FlutterProjectTemplate]
  /// - Flag: `--template=...`
  final String template;

  /// Weather to generate the project as an empty app
  /// - Flag: `-e`
  final bool isEmptyApp;

  /// Android code language (e.g. java, kotlin)
  /// - Flag: `--android-language=...`
  final String? androidLanguage;

  /// Project platforms (e.g. android, ios)
  /// - Flag: `--platforms=...`
  final List<String> platforms;

  /// Weather to run `pub get` after project creation
  /// - Flag: `--pub` or `--no-pub`
  final bool shouldRunPubGet;

  /// Weather to run `pub get` in offline mode
  /// - Flag: `--offline` or `--no-offline`
  final bool isOfflineMode;

  /// Weather to overwrite existing project
  /// - Flag: `--overwrite`
  final bool shouldOverwrite;

  @override
  String get executableName => 'flutter';

  @override
  String get commandName => 'create';

  @override
  List<String> get args => [
        projectName,
        if (organization.isNotEmpty) '--org=$organization',
        '--template=$template',
        if (platforms.isNotEmpty) '--platforms=${platforms.join(',')}',
        if (androidLanguage != null) '--android-language=$androidLanguage',
        if (description.isNotEmpty) '--description=$description',
        shouldRunPubGet ? '--pub' : '--no-pub',
        isOfflineMode ? '--offline' : '--no-offline',
        if (shouldOverwrite) '--overwrite',
        if (isEmptyApp) '-e',
      ];

  String get projectDir => p.join(projectParentDir, projectName);
}
