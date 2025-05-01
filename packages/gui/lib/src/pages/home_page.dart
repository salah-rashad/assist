import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.projectPath});

  final String projectPath;

  @override
  Widget build(BuildContext context) {
    // Get the PROJECT_DIR value passed from the command line
    String projectDir = const String.fromEnvironment(
      'assist_pwd',
      defaultValue: 'Unknown',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Assist')),
      body: Center(child: Text('Project Directory: $projectDir')),
    );
  }
}
