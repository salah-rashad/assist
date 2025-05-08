import 'package:assist_core/services/service.secure_storage.dart';
import 'package:assist_gui/app/app.dart';
import 'package:assist_gui/core/constants/constants.dart';
import 'package:assist_gui/core/constants/env.dart';
import 'package:assist_gui/core/utils/bloc_observer.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SecureStorageManager.initialize();

  EasyLocalization.logger.enableLevels = [];
  Bloc.observer = AppBlocObserver();

  // if project path is provided as an argument, use it
  // otherwise, use the environment variable
  //
  // Project path is expected to be provided from arguments when running
  // from release mode.
  //
  // And it is expected to be provided from environment variable when running
  // from debug mode
  final projectPath = args.isNotEmpty ? args[0] : Env.pwd;

  runApp(
    EasyLocalization(
      supportedLocales: Constants.supportedLocales,
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MainApp(projectPath: projectPath),
    ),
  );
}
