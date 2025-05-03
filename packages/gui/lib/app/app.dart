import 'package:assist_core/constants/strings.dart';
import 'package:assist_core/services/task_manager/task_event.dart';
import 'package:assist_gui/app/routing/app_router.dart';
import 'package:assist_gui/app/themes/app_theme.dart';
import 'package:assist_gui/features/auth/controller/auth_cubit.dart';
import 'package:assist_gui/features/project/controller/project_cubit.dart';
import 'package:assist_gui/features/settings/controller/settings_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../core/constants/env.dart';
import '../core/utils/task_event_handler.dart';
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
        BlocProvider(create: (_) => TaskManagerCubit(), lazy: true),
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
              return BlocListener<TaskManagerCubit, TaskEvent?>(
                listener: handleTaskEvent,
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
