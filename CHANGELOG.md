# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## 2025-05-09

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`assist` - `v0.3.1`](#assist---v031)
 - [`assist_core` - `v0.3.1`](#assist_core---v031)
 - [`assist_gui` - `v0.3.1`](#assist_gui---v031)

---

#### `assist` - `v0.3.1`

 - **REFACTOR**: simplify SupportedPlatform enum and update GUI executable path logic.
 - **REFACTOR**(core): remove redundant core directory.
 - **FIX**: fix install issues in service.install.dart.
 - **FEAT**: update version to 0.3.0 and add version update script that runs after `melos version`.
 - **FEAT**(cli): add debug mode flag, primitive implementation of the install command, and update the run command.
 - **FEAT**(cli): update exception imports to use exceptions.cli.dart for CLI tasks.
 - **FEAT**: update and apply analysis options everywhere.
 - **DOCS**: add build GUI release badge to README.
 - **DOCS**(cli): add preview section to README showcasing terminal output vs interactive GUI.

#### `assist_core` - `v0.3.1`

 - **REFACTOR**: simplify SupportedPlatform enum and update GUI executable path logic.
 - **REFACTOR**(core): refactor task management system.
 - **REFACTOR**(core): remove redundant core directory.
 - **FIX**(core): fix result handling in shell tasks.
 - **FEAT**(core): enhance CliException, implement AssistConfigManager for loading and saving configuration, implement SupportedPlatform enum, and update constants.
 - **FEAT**(core): enhance test suite handling with load failure detection and apply clean up tweaks to the whole report.
 - **FEAT**(core): enhance task management with improved error handling and unit test result parsing.
 - **FEAT**: update and apply analysis options everywhere.
 - **FEAT**(core): implement ShellTask for task execution and refactor existing tasks.
 - **FEAT**(core): add project check tasks implementation, update task base class, and update project model to detect project type.
 - **FEAT**(core): enhance task management with cancellable tasks and event handling.
 - **FEAT**(core): implement assist task framework with task management and results.

#### `assist_gui` - `v0.3.1`

 - **REFACTOR**(gui): refactor task event handling and improve task manager integration.
 - **REFACTOR**(core): remove redundant core directory.
 - **PERF**: use melos v7.0.0-dev.8 pre-release with pub workspaces for better ide analyzer performance and monorepo management.
 - **FIX**(gui): update text color logic in shell task report dialog.
 - **FIX**: update version command hook to post, and fix update_version.dart.
 - **FIX**: fix melos version pre-commit hook.
 - **FIX**: set min Dart SDK version to ^3.6.0.
 - **FEAT**(gui): update projectPath variable handling in main.
 - **FEAT**(gui): add image assets and enhance task dialogs (shell and unit test) with improved styling.
 - **FEAT**(gui): add minimum height constraint to terminal styled card for improved layout.
 - **FEAT**(gui): enhance task reporting, implement special unit test report dialog, other improvements.
 - **FEAT**(gui): implement status check tasks system, task status bar, task result details dialog, and refactor dashboard layout.
 - **FEAT**(gui): implement task manager with event handling and result notification.
 - **FEAT**(gui): implement ProjectHealthCard for improved status display.
 - **FEAT**(gui): Add ability to create status badge with custom color.
 - **FEAT**(gui): Add initial project structure with core services, themes, and UI components.


## 2025-05-01

### Changes

---

Packages with breaking changes:

- There are no breaking changes in this release.

Packages with other changes:

- [`assist` - `v0.3.0`](#assist---v030)
- [`assist_core` - `v0.3.0`](#assist_core---v030)

---

#### `assist` - `v0.3.0`

- **REFACTOR**: move core files to `assist_core` and migrate CLI to depend on `assist_core` package.
- **PERF**: use melos v7.0.0-dev.8 pre-release with pub workspaces for better ide analyzer
  performance and monorepo management.
- **FIX**: set min Dart SDK version to ^3.6.0.
- **FIX**: clean up pubspec.yaml and improve command formatting in cli.printer.dart.
- **FIX**: update choice generation to use title case for better readability.
- **FEAT**: add/update `README.md` and `CONTRIBUTING.md`.
- **FEAT**(gui): Add initial project structure with core services, themes, and UI components.

#### `assist_core` - `v0.3.0`

- **REFACTOR**: move core files to `assist_core` and migrate CLI to depend on `assist_core` package.
- **PERF**: use melos v7.0.0-dev.8 pre-release with pub workspaces for better ide analyzer
  performance and monorepo management.
- **FIX**: set min Dart SDK version to ^3.6.0.
- **FEAT**(gui): Add initial project structure with core services, themes, and UI components.
- **DOCS**: Update README.md of the assist_core package.

