import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the PROJECT_DIR value passed from the command line
    String projectDir = const String.fromEnvironment(
      'PROJECT_DIR',
      defaultValue: 'Unknown',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Pub Assist')),
      body: Center(child: Text('Project Directory: $projectDir')),
    );
  }
}
