import 'dart:io';

import 'package:assist_core/models/project.dart';
import 'package:assist_core/services/service.project_watcher.dart';
import 'package:assist_core/services/service.pubspec.dart';
import 'package:assist_gui/core/utils/logger.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

part 'project_state.dart';

class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit({required String projectPath})
    : assert(projectPath.isNotEmpty, 'Project path must not be empty'),
      assert(
        Directory(projectPath).existsSync(),
        'Project path does not exist',
      ),
      project = Project(path: projectPath),
      super(ProjectInitial());

  final Project project;
  final _watcher = ProjectFileWatcherService();

  @override
  Future<void> close() {
    _watcher.dispose();
    return super.close();
  }

  load() {
    emit(ProjectLoading());

    Logger.gray('Loading project...');
    Logger.data('Path', project.path);

    _initializePubspec();
    // _watchProjectFiles();

    Logger.data('🚀', 'Project loaded');

    emit(ProjectLoaded());
  }

  void _initializePubspec() {
    final pubspecPath = p.join(project.path, 'pubspec.yaml');
    final pubspecService = PubspecService();
    final pubspec = pubspecService.parse(pubspecPath);
    project.pubspec = pubspec;
    Logger.data('✔', 'Pubspec loaded');
  }

  // void _watchProjectFiles() {
  //   _watcher.dispose();
  //   _watcher.events.listen(
  //     (event) {
  //       switch (event.fileType) {
  //         case ProjectFileType.pubspec:
  //           _initializePubspec();
  //           emit(PubspecChanged());
  //           break;
  //         case ProjectFileType.changelog:
  //           emit(ChangelogChanged());
  //           break;
  //         case ProjectFileType.readme:
  //           emit(ReadmeChanged());
  //           break;
  //         case ProjectFileType.other:
  //           break;
  //       }
  //     },
  //     onError: (error) {
  //       Logger.error('Error watching project', error);
  //     },
  //   );
  //   _watcher.start(projectPath: project.path);
  //   Logger.data('🕵', 'Project is being watched');
  // }

  reload() {
    _watcher.dispose();
    load();
  }
}
