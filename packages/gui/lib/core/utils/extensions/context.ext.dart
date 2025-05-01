import 'package:assist_core/assist_core.dart';
import 'package:assist_core/models/project.dart';
import 'package:assist_gui/core/utils/extensions/shad_theme.ext.dart';
import 'package:assist_gui/features/auth/controller/auth_cubit.dart';
import 'package:assist_gui/features/project/controller/project_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../app/themes/theme_extenstions/extended_colors.dart';

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

// extension ContextTaskManager on BuildContext {
//   List<AssistTask> get tasks => taskManager.pendingTasks;
// }
