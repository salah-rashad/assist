import 'package:assist_core/assist_core.dart';
import 'package:assist_core/models/project.dart';
import 'package:assist_core/services/task_manager/task_manager.dart';
import 'package:assist_gui/app/themes/theme_extenstions/extended_colors.dart';
import 'package:assist_gui/core/utils/extensions/shad_theme.ext.dart';
import 'package:assist_gui/features/auth/controller/auth_cubit.dart';
import 'package:assist_gui/features/project/controller/project_cubit.dart';
import 'package:assist_gui/features/task_manager/controller/task_manager_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

extension ContextTheme on BuildContext {
  ShadThemeData get theme => ShadTheme.of(this);

  ShadColorScheme get colorScheme => theme.colorScheme;

  ShadTextTheme get textTheme => theme.textTheme;

  bool get isDark => theme.brightness == Brightness.dark;

  ExtendedColors get extendedColors =>
      theme.extension<ExtendedColors>() ?? ExtendedColors.fallback();
}

extension ContextUser on BuildContext {
  CurrentUser get user => read<AuthCubit>().user;
}

extension ContextProject on BuildContext {
  Project get project => read<ProjectCubit>().project;

  Pubspec get pubspec => project.pubspec;
}

extension ContextTaskManager on BuildContext {
  TaskManagerCubit get taskManager => read<TaskManagerCubit>();
  List<Task> get tasks => taskManager.pendingTasks;
}

extension ContextShadToast on BuildContext {
  void hideSonner(Object? id) {
    ShadSonner.maybeOf(this)?.hide(id);
  }

  void showSonner(ShadToast toast) {
    ShadSonner.maybeOf(this)?.show(toast);
  }

  dynamic showSuccessSonner([String? title, String? description]) {
    return showSonner(
      ShadToast(
        backgroundColor: extendedColors.success,
        title: Text(title ?? ''),
        description: Text(description ?? ''),
        titleStyle: theme.primaryToastTheme.titleStyle?.apply(
          color: colorScheme.background,
        ),
        descriptionStyle: theme.primaryToastTheme.titleStyle?.apply(
          color: colorScheme.background,
        ),
      ),
    );
  }

  dynamic showErrorSonner([String? title, String? description]) {
    return showSonner(
      ShadToast.destructive(
        title: Text(title ?? ''),
        description: Text(description ?? ''),
      ),
    );
  }

  void showTaskErrorSonner(Task task, Object? error, {bool showRetry = true}) {
    final id = task.id;

    final toast = ShadToast.destructive(
      id: id,
      duration: const Duration(seconds: 10),
      title: Text(task.name),
      description: Text(
        error.toString(),
        maxLines: 8,
        overflow: TextOverflow.fade,
      ),
      action: !showRetry
          ? null
          : ShadButton.secondary(
              onPressed: () {
                taskManager.submitTask(task);
                hideSonner(id);
              },
              child: Text('Retry'),
            ),
    );

    showSonner(toast);
  }
}
