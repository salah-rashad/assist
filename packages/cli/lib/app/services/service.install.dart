import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:assist/app/core/cli.strings.dart';
import 'package:assist/app/utils/cli.extensions.dart';
import 'package:assist/main.dart';
import 'package:assist_core/constants/supported_platform.dart';
import 'package:assist_core/services/assist_config_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

/// Service to install the GUI
class InstallService {
  static const _owner = 'salah-rashad';
  static const _repo = 'assist';

  Directory getInstallDirectory() {
    final platform = SupportedPlatform.current;
    final directory = Directory(platform.getGuiInstallPath());

    return directory..createSync(recursive: true);
  }

  /*Future downloadGUIApp() async {
    const totalSize = 25 * 1024 * 1024; // 25 MB
    const chunkMin = 1 * 1024 * 1024; // 2 MB
    const chunkMax = 3 * 1024 * 1024; // 3 MB
    const delay = Duration(milliseconds: 500);

    final rng = Random();
    int received = 0;
    final stopwatch = Stopwatch()..start();

    Stream<int> simulatedDownloadStream() async* {
      while (received < totalSize) {
        // simulate variable chunk sizes (like real-world network)
        final chunk = min(
          chunkMin + rng.nextInt(chunkMax - chunkMin),
          totalSize - received,
        );
        await Future.delayed(delay);
        received += chunk;
        yield chunk;
      }
    }

    final progressState = progress(
      'Downloading...',
      length: totalSize,
      endLabel: (progress) => '${toMegaBytes(progress.filled)} MB'
          ' / '
          '${toMegaBytes(progress.length)} MB',
    );

    await for (final r in simulatedDownloadStream()) {
      progressState.increase(r);
      if (received >= totalSize) {
        stopwatch.stop();
        sleep(Duration(seconds: 1));
        progressState.finish(
          'Download Complete',
          '${toMegaBytes(totalSize)} MB '
              '(${(stopwatch.elapsed.inMilliseconds / 1000).toStringAsFixed(1)} s)',
        );
      }
    }
  }*/

  /*Future<String> promptInstallDirectory() async {
    return prompt(
      'Install directory path:',
      defaultValue: Directory.current.path,
      validator: GenericValidator("Directory does not exist.", (value) {
        if (Directory(value).existsSync()) {
          return true;
        }
        return false;
      }),
    );
  }*/

  String _getArchiveFileName(SupportedPlatform platform, String version) {
    return switch (platform) {
      SupportedPlatform.windows => 'assist_gui-windows-assist-v$version.zip',
      SupportedPlatform.linux => 'assist_gui-linux-assist-v$version.tar.gz',
      SupportedPlatform.macos => 'assist_gui-macos-assist-v$version.zip',
    };
  }

  Future<void> _extractArchive(String archivePath, String outputDir) async {
    final file = File(archivePath);
    final bytes = file.readAsBytesSync();

    if (archivePath.endsWith('.zip')) {
      final archive = ZipDecoder().decodeBytes(bytes);
      extractArchiveToDisk(archive, outputDir);
    } else if (archivePath.endsWith('.tar.gz')) {
      final archive =
          TarDecoder().decodeBytes(GZipDecoder().decodeBytes(bytes));
      await extractArchiveToDisk(archive, outputDir);
    } else {
      throw Exception('Unsupported archive format.');
    }
  }

  String? _findExecutable(String extractedDir) {
    final files = Directory(extractedDir).listSync(recursive: true);

    for (final file in files) {
      final name = p.basename(file.path).toLowerCase();

      if (Platform.isWindows && name.endsWith('.exe')) {
        return file.path;
      } else if (Platform.isMacOS &&
          file.path.contains('.app/Contents/MacOS/')) {
        return file.path;
      } else if (Platform.isLinux && name == 'assist_gui') {
        return file.path;
      }
    }
    return null;
  }

  Future<void> install() async {
    final cliVersion = app.version ?? CliStrings.version;
    final platform = SupportedPlatform.current;
    final fileName = _getArchiveFileName(platform, cliVersion);

    final releaseUrl =
        'https://github.com/$_owner/$_repo/releases/download/assist-v$cliVersion/$fileName';

    final tempDir = Directory.systemTemp.createTempSync('assist_gui_');
    final archivePath = p.join(tempDir.path, fileName);
    final extractedPath = p.join(tempDir.path, 'extracted');

    print('Temp dir: ${tempDir.path}');

    print('⬇️ Downloading GUI release for $platform...');
    print(releaseUrl);
    final response = await http.get(Uri.parse(releaseUrl));

    if (response.statusCode != 200) {
      throw Exception('❌ Failed to download GUI: ${response.statusCode}');
    }

    await File(archivePath).writeAsBytes(response.bodyBytes);

    print('📦 Extracting...');
    await _extractArchive(archivePath, extractedPath);

    final installPath = getInstallDirectory().path;
    final installDir = Directory(installPath);

    if (!installDir.existsSync()) {
      installDir.createSync(recursive: true);
    }

    // Move full bundle into installDir
    _copyDirectory(Directory(extractedPath), Directory(installPath));

    // Clean up
    // tempDir.deleteSync(recursive: true);

    // Find entry executable
    final guiExecutable = _findExecutable(installPath);
    if (guiExecutable == null) {
      throw Exception('❌ Could not find GUI executable inside bundle.');
    }

    if (Platform.isLinux || Platform.isMacOS) {
      await Process.run('chmod', ['+x', guiExecutable]);
    }

    print('✅ Installed GUI to: $installPath');

    // Update config
    await AssistConfigManager.updateGuiData(
      path: guiExecutable,
      bundle: installPath,
    );

    await AssistConfigManager.setVersion(cliVersion);

    // await task(
    //   'Decompressing Data...',
    //   task: (spinner) async {
    //     await _uncompressData();
    //   },
    //   successMessage: '[Done] ${'Decompression'.gray()}',
    // );
    // line();
    // await task(
    //   'Configuring...',
    //   task: (spinner) async {
    //     await _uncompressData();
    //   },
    //   successMessage: '[Done] ${'Configuration'.gray()} ',
    // );
    // line();
    // await task(
    //   'Installing data...',
    //   task: (spinner) async {
    //     await _install();
    //   },
    //   successMessage: '[Done] ${'Installation'.gray()}',
    // );
  }

  void _copyDirectory(Directory source, Directory destination) {
    if (!destination.existsSync()) {
      destination.createSync(recursive: true);
    }

    for (final entity in source.listSync(recursive: true)) {
      final relativePath = entity.path.substring(source.path.length + 1);
      final newPath = p.join(destination.path, relativePath);

      if (entity is File) {
        File(newPath).createSync(recursive: true);
        entity.copySync(newPath);
      } else if (entity is Directory) {
        Directory(newPath).createSync(recursive: true);
      }
    }
  }
}
