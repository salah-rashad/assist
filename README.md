<img src="assets/images/poster.png" alt="Poster"/>

<a href="https://pub.dev/packages/assist" target="_blank">
    <img src="https://img.shields.io/pub/v/assist.svg?label=Pub&labelColor=black&" alt="Pub Version"/>
    <img src="https://img.shields.io/pub/points/assist?label=Points&labelColor=black&color=229954" alt="Pub Points"/>
    <img src="https://img.shields.io/pub/dm/assist.svg?label=Downloads&labelColor=black&color=34495e" alt="Pub Downloads"/>
</a>

[![Build GUI Release](https://github.com/salah-rashad/assist/actions/workflows/build_gui_release.yml/badge.svg)](https://github.com/salah-rashad/assist/actions/workflows/build_gui_release.yml)

---

#### 🚧 Under Development 🚧

> [!WARNING]  
> This project is still in development and is not yet ready for production use.  
> Please use with caution and file any potential issues
> on [GitHub](https://github.com/salah-rashad/assist/issues).

---

# Assist

**Assist** is a unified tool that helps automate repetitive tasks in Dart and Flutter package
development.  
It provides a command-line interface (CLI) and a graphical user interface (GUI) to improve the
developer experience from project creation to publication.

This repository follows a **monorepo structure** to organize the project into independent, focused
packages.

## ✨ Features

- Create new Dart and Flutter projects
- Automate version bumping and changelog updates
- Pre-publish project checks (format, analyze, test)
- Documentation tools (README and CHANGELOG management)
- CI/CD helpers (GitHub workflow generator)
- Publish packages more reliably and faster

> 📄 For the full list of planned and completed goals, see [GOALS.md](./GOALS.md).

## 📦 Project Structure

Assist is organized as a **monorepo** using [Melos](https://melos.invertase.dev/):

```
packages/
├── core/   # Shared services, models, and utilities
├── cli/    # Command-line tool for package automation
└── gui/    # Flutter-based GUI for visual project management
```

## 🧰 Prerequisites

- **Dart SDK** 3.6.0 or later
- **Flutter SDK** 3.27.0 or later (for GUI)

## 🛠️ Setup Instructions

1. Fork the repository.

2. Clone your fork:
   ```bash
   git clone https://github.com/<your-username>/assist.git
   cd assist
   ```
3. Install Melos:
   ```bash
   dart pub global activate melos
   ```

4. Bootstrap all packages:
   ```bash
   melos bootstrap
   ```

5. Choose the package you want to work on:
   - CLI tool: `assist`
   - Core logic: `assist_core`
   - GUI app: `assist_gui`

6. Make your changes.

## 🐞 Debugging the CLI

To run your CLI version with your changes:

1. Activate the CLI globally (once):
   - Method 1: (Using Melos)
      ```bash
      melos run activate
      ```
   - Method 2: (Manually)
      ```bash
      dart pub upgrade
      rm -rf ./.dart_tool/pub/bin/assist_workspace
      dart pub global activate --source="path" . --executable="assist-dev" --overwrite
      ```
2. Run the CLI in development mode:
   ```bash
   assist-dev
   # Now you can run assist anywhere with your changes
   ```

## 🐞 Debugging the GUI

The GUI requires a local Dart/Flutter project to run in.

To run the GUI with your changes:

1. Update the `ASSIST_PWD` variable in `.env` file to your desired local project directory.
2. Run the GUI:
   - **_Android Studio_**: run  the `gui` run configuration.
   - **_VS Code_**: run the `gui` run configuration in the `.vscode/launch.json` file.

---

## 🤝 Contributing

We welcome contributions!  
Check the [Contributing Guide](CONTRIBUTING.md) or open an issue to suggest improvements.

## ⚖️ License

This project is licensed under the BSD 3-Clause License.


<div align="center">
  Made with ❤️ in Egypt 🇪🇬
  <br/>
  <h3>🇵🇸 Free Palestine 🇵🇸</h3>
</div>
