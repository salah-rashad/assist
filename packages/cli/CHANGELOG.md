## 0.3.1

 - **REFACTOR**: simplify SupportedPlatform enum and update GUI executable path logic.
 - **REFACTOR**(core): remove redundant core directory.
 - **FIX**: fix install issues in service.install.dart.
 - **FEAT**: update version to 0.3.0 and add version update script that runs after `melos version`.
 - **FEAT**(cli): add debug mode flag, primitive implementation of the install command, and update the run command.
 - **FEAT**(cli): update exception imports to use exceptions.cli.dart for CLI tasks.
 - **FEAT**: update and apply analysis options everywhere.
 - **DOCS**: add build GUI release badge to README.
 - **DOCS**(cli): add preview section to README showcasing terminal output vs interactive GUI.

## 0.3.0

- **REFACTOR**: move core files to `assist_core` and migrate CLI to depend on `assist_core` package.
- **PERF**: use melos v7.0.0-dev.8 pre-release with pub workspaces for better ide analyzer
  performance and monorepo management.
- **FIX**: set min Dart SDK version to ^3.6.0.
- **FIX**: clean up pubspec.yaml and improve command formatting in cli.printer.dart.
- **FIX**: update choice generation to use title case for better readability.
- **FEAT**: add/update `README.md` and `CONTRIBUTING.md`.
- **FEAT**(gui): Add initial project structure with core services, themes, and UI components.

## 0.2.2

- Enhance color handling in CLI.
- Update paths and imports.
- Update `README.md`.
- Add example `README.md`.

## 0.2.1

- Fixed the working directory path in the Flutter create service.
- Refactor services, moved flutter tasks to `FlutterService` and dart tasks to `DartService` for
  better organization.

## 0.2.0

- Added the `create` command.
- Implemented Dart project creation.
- Implemented Flutter project creation.
- Updated code documentation.
- Organized tasks into separate classes for better structure.
- Updated `README.md`.

## 0.1.0+1

- Updated `README.md`.

## 0.1.0

- Initial release.