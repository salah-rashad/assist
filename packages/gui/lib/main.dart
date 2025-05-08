import 'package:assist_core/services/service.secure_storage.dart';
import 'package:assist_gui/app/app.dart';
import 'package:assist_gui/core/constants/constants.dart';
import 'package:assist_gui/core/utils/bloc_observer.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SecureStorageManager.initialize();

  EasyLocalization.logger.enableLevels = [];
  Bloc.observer = AppBlocObserver();

  runApp(
    EasyLocalization(
      supportedLocales: Constants.supportedLocales,
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: const MainApp(),
    ),
  );
}
