import 'package:flutter/material.dart';
import 'core/widgets/app_lifecycle_manager.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLifecycleManager(
      child: MaterialApp(
        title: 'Flutter Starter Kit',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const Scaffold(
          body: Center(
            child: Text('Flutter Starter Kit'),
          ),
        ),
      ),
    );
  }
} 