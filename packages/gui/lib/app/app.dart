import 'package:assist_core/constants/strings.dart';
import 'package:assist_core/tasks/base/task_event.dart';
import 'package:assist_gui/app/routing/app_router.dart';
import 'package:assist_gui/app/themes/app_theme.dart';
import 'package:assist_gui/core/utils/extensions.dart';
import 'package:assist_gui/features/auth/controller/auth_cubit.dart';
import 'package:assist_gui/features/project/controller/project_cubit.dart';
import 'package:assist_gui/features/settings/controller/settings_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../core/constants/env.dart';
import '../features/task_manager/controller/task_manager_cubit.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProjectCubit(projectPath: Env.pwd)..load(),
          lazy: false,
        ),
        BlocProvider(create: (_) => AuthCubit(), lazy: false),
        BlocProvider(create: (_) => SettingsCubit(), lazy: false),
        BlocProvider(create: (_) => TaskManagerCubit()),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final settingsCubit = context.read<SettingsCubit>();
          return ShadApp.router(
            title: Strings.appName,
            routerConfig: AppRouter.router,
            themeMode: settingsCubit.themeMode,
            theme: AppTheme.light.themeData(),
            darkTheme: AppTheme.dark.themeData(),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            builder: (context, child) {
              return BlocListener<TaskManagerCubit, TaskManagerState>(
                listener: (context, state) {
                  if (state is TaskManagerEvent) {
                    _handleTaskEvent(state.event, context);
                  }
                },
                child: child!,
              );
            },
          );
        },
      ),
    );
  }

  void _handleTaskEvent(TaskEvent event, BuildContext context) {
    final name = event.name;
    final message = event.message;
    final messageText = message != null ? Text(message) : null;

    final toast = switch (event) {
      TaskSuccess() => ShadToast(
          backgroundColor: context.extendedColors.success,
          title: Text("$name [Success]"),
          description: messageText,
          titleStyle: context.theme.primaryToastTheme.titleStyle?.apply(
            color: context.colorScheme.background,
          ),
          descriptionStyle: context.theme.primaryToastTheme.titleStyle?.apply(
            color: context.colorScheme.background,
          ),
        ),
      TaskFailed() => ShadToast.destructive(
          title: Text("$name [Failed]"),
          description: messageText,
        ),
      TaskCancelled() => ShadToast.destructive(
          title: Text("$name [Cancelled]"),
          description: messageText,
        ),
      _ => null,
    };

    if (toast != null) {
      ShadSonner.maybeOf(context)?.show(toast);
    }
  }
}
