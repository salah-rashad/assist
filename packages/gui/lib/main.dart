import 'package:flutter/material.dart';
import 'package:gui/src/pages/home_page.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  final projectPath = args.isNotEmpty ? args.first : 'No path provided';
  runApp(MyApp(projectPath: projectPath));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.projectPath});

  final String projectPath;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assist',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: HomePage(projectPath: projectPath),
    );
  }
}
