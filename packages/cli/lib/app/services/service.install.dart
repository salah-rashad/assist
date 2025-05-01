import 'dart:io';
import 'dart:math';

import 'package:assist_core/constants/paths.dart';
import 'package:path/path.dart' as p;
import 'package:promptly/promptly.dart';

import '../utils/cli.helpers.dart';

/// Service to install the GUI
class InstallService {
  Directory _getTempDirectory() {
    final systemTempDir = Directory.systemTemp;
    final directory = Directory(p.join(systemTempDir.path, kTempDir));
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    return directory;
  }

  Directory getGuiInstallDir() =>
      Directory(p.join(_getTempDirectory().path, kGuiDir))
        ..createSync(recursive: true);

  // Future<String> promptInstallDirectory() async {
  //   return prompt(
  //     'Install directory path:',
  //     defaultValue: Directory.current.path,
  //     validator: GenericValidator("Directory does not exist.", (value) {
  //       if (Directory(value).existsSync()) {
  //         return true;
  //       }
  //       return false;
  //     }),
  //   );
  // }

  Future downloadGUIApp() async {
    const totalSize = 25 * 1024 * 1024; // 25 MB
    const chunkMin = 2 * 1024 * 1024; // 2 MB
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
  }

  Future install(String installDir) async {
    await task(
      "Decompressing Data...",
      task: (spinner) async {
        await _uncompressData();
      },
      successMessage: '[Done] ${'Decompression'.gray()}',
    );
    line();
    await task(
      "Configuring...",
      task: (spinner) async {
        await _uncompressData();
      },
      successMessage: '[Done] ${'Configuration'.gray()} ',
    );
    line();
    await task(
      "Installing data...",
      task: (spinner) async {
        await _install();
      },
      successMessage: '[Done] ${'Installation'.gray()}',
    );
  }

  Future<void> _uncompressData() {
    return Future.delayed(Duration(seconds: 3));
  }

  Future<void> _install() {
    return Future.delayed(Duration(seconds: 3));
  }
}
