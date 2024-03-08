import 'package:flutter/material.dart';
import 'package:task_manager_app/core/utils/locator.dart';
import 'package:task_manager_app/presentation/task/task_listing_screen.dart';

import 'bloc/task_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TaskListingScreen(taskBloc: locator<TaskBloc>()),
    );
  }
}
