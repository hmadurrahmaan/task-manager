import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_manager_app/bloc/task_bloc.dart';
import 'package:task_manager_app/core/utils/locator.dart';
import 'package:task_manager_app/data/model/task_model.dart';
import 'package:task_manager_app/presentation/task/add_task_screen.dart';
import 'package:task_manager_app/presentation/task/task_listing_screen.dart';
import 'package:task_manager_app/presentation/task/widget/task_item.dart';

class MockTaskBloc extends Mock implements TaskBloc {}

void main() {
  group('Task Manager App Widget Tests', () {
    late TaskBloc mockTaskBloc;

    setUp(() {
      mockTaskBloc = MockTaskBloc();
    });

    testWidgets('Renders title and progress indicator while loading tasks',
        (WidgetTester tester) async {
      when(() => mockTaskBloc.state).thenAnswer((_) => TaskLoadingState());

      await tester.pumpWidget(MaterialApp(
        home: TaskListingScreen(taskBloc: mockTaskBloc),
      ));

      expect(find.text('Task Manager'), findsOneWidget);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      expect(find.text('No Tasks Added'), findsNothing);
    });

    testWidgets('AddTaskScreen UI Test', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AddTaskScreen()));

      expect(find.text('Add Task'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Add'), findsOneWidget);
    });

    testWidgets('TaskItem UI Test', (WidgetTester tester) async {
      // Create a TaskModel for testing
      const task = TaskModel(id: '1', title: 'Test Task');

      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: TaskItem(task: task),
        ),
      ));

      expect(find.text('Test Task'), findsOneWidget);
      expect(find.byIcon(Icons.delete), findsOneWidget);
    });
  });
}
