import 'dart:io';

import 'package:assist_core/models/project.dart';
import 'package:assist_core/services/service.project_watcher.dart';
import 'package:assist_core/services/service.pubspec.dart';
import 'package:assist_gui/core/utils/logger.dart';
import 'package:assist_gui/features/task_manager/controller/mixins/status_check_tasks.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as p;

part 'project_state.dart';

class ProjectCubit extends Cubit<ProjectState> with StatusCheckTasks {
  ProjectCubit({required String projectPath})
      : project = Project(path: projectPath),
        assert(projectPath.isNotEmpty, 'Project path must not be empty'),
        assert(
          Directory(projectPath).existsSync(),
          'Project path does not exist',
        ),
        super(ProjectInitial()) {
    initializeCheckTasks(project);
  }

  final Project project;
  final _watcher = ProjectFileWatcherService();

  @override
  Future<void> close() {
    _watcher.dispose();
    return super.close();
  }

  void load(BuildContext context) {
    emit(ProjectLoading());

    Logger.gray('Loading project...');
    Logger.data('Path', project.path);

    _initializePubspec();
    runStatusCheck(context);
    _watchProjectFiles();

    Logger.data('🚀', 'Project loaded');

    emit(ProjectLoaded());
  }

  void reload(BuildContext context) {
    _watcher.dispose();
    load(context);
  }

  void _initializePubspec() {
    final pubspecPath = p.join(project.path, 'pubspec.yaml');
    final pubspecService = PubspecService();
    final pubspec = pubspecService.parse(pubspecPath);
    project.pubspec = pubspec;
    Logger.data('✔', 'Pubspec loaded');
  }

  void _watchProjectFiles() {
    // _watcher.dispose();
    // _watcher.events.listen(
    //   (event) {
    //     switch (event.fileType) {
    //       case ProjectFileType.pubspec:
    //         _initializePubspec();
    //         emit(PubspecChanged());
    //         break;
    //       case ProjectFileType.changelog:
    //         emit(ChangelogChanged());
    //         break;
    //       case ProjectFileType.readme:
    //         emit(ReadmeChanged());
    //         break;
    //       case ProjectFileType.other:
    //         break;
    //     }
    //   },
    //   onError: (error) {
    //     Logger.error('Error watching project', error);
    //   },
    // );
    // _watcher.start(projectPath: project.path);
    // Logger.data('🕵', 'Project is being watched');
  }
}
