# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

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

