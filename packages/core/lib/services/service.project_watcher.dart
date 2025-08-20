import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';

enum ProjectFileType { pubspec, changelog, readme, other }

enum ProjectFileEventType { modified, deleted, moved }

class ProjectFileEvent extends Equatable {
  final ProjectFileType fileType;
  final ProjectFileEventType eventType;
  final String path;

  ProjectFileEvent(this.fileType, this.eventType, this.path);

  @override
  List<Object?> get props => [fileType, eventType, path];
}

/// Service for watching project files and triggering events when they change
/// e.g. `pubspec.yaml` or `CHANGELOG.md`
class ProjectFileWatcherService {
  final Duration debounceDuration;

  final _controller = StreamController<ProjectFileEvent>.broadcast();
  StreamSubscription<FileSystemEvent>? _watchSubscription;
  Timer? _debounceTimer;

  ProjectFileWatcherService({
    this.debounceDuration = const Duration(seconds: 2),
  });

  final Map<String, ProjectFileType> _watchedFiles = {
    'pubspec.yaml': ProjectFileType.pubspec,
    'README.md': ProjectFileType.readme,
    'CHANGELOG.md': ProjectFileType.changelog,
  };

  /// Public stream to listen to project file events
  Stream<ProjectFileEvent> get events => _controller.stream;

  void start({required String projectPath}) {
    if (_watchSubscription != null) {
      _watchSubscription?.cancel();
    }

    final dir = Directory(projectPath);

    if (!dir.existsSync()) {
      throw FileSystemException('Project path does not exist', projectPath);
    }

    _watchSubscription = dir.watch(recursive: false).listen((event) {
      final fileName = _getFileName(event.path);
      final fileType = _watchedFiles[fileName];

      if (fileType != null) {
        final eventType = _mapEventType(event);

        // Debounce grouped changes (e.g. save = write+move)
        _debounceTimer?.cancel();
        _debounceTimer = Timer(debounceDuration, () {
          _controller.add(ProjectFileEvent(fileType, eventType, event.path));
        });
      }
    });
  }

  void dispose() {
    _watchSubscription?.cancel();
    _debounceTimer?.cancel();
    _controller.close();
  }

  ProjectFileEventType _mapEventType(FileSystemEvent event) {
    if (event is FileSystemModifyEvent) {
      return ProjectFileEventType.modified;
    } else if (event is FileSystemDeleteEvent) {
      return ProjectFileEventType.deleted;
    } else if (event is FileSystemMoveEvent) {
      return ProjectFileEventType.moved;
    }
    return ProjectFileEventType.modified;
  }

  String _getFileName(String fullPath) {
    return fullPath.split(Platform.pathSeparator).last;
  }
}
