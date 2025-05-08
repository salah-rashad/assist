## 0.3.1

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

## 0.3.0

- **REFACTOR**: move core files to `assist_core` and migrate CLI to depend on `assist_core` package.
- **PERF**: use melos v7.0.0-dev.8 pre-release with pub workspaces for better ide analyzer
  performance and monorepo management.
- **FIX**: set min Dart SDK version to ^3.6.0.
- **FEAT**(gui): Add initial project structure with core services, themes, and UI components.
- **DOCS**: Update README.md of the assist_core package.

## 0.1.0

- Initial version.
