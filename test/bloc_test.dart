import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_manager_app/bloc/task_bloc.dart';
import 'package:task_manager_app/domain/usecase/add_task_usecase.dart';
import 'package:task_manager_app/domain/usecase/delete_task_usecase.dart';
import 'package:task_manager_app/domain/usecase/fetch_task_usecase.dart';
import 'package:task_manager_app/data/model/task_model.dart';

class MockFetchTaskUseCase extends Mock implements FetchTaskUseCase {}

class MockAddTaskUseCase extends Mock implements AddTaskUseCase {}

class MockDeleteTaskUseCase extends Mock implements DeleteTaskUseCase {}

void main() {
  group('TaskBloc', () {
    late MockFetchTaskUseCase fetchTaskUseCase;
    late MockAddTaskUseCase addTaskUseCase;
    late MockDeleteTaskUseCase deleteTaskUseCase;
    late TaskBloc taskBloc;

    setUp(() {
      fetchTaskUseCase = MockFetchTaskUseCase();
      addTaskUseCase = MockAddTaskUseCase();
      deleteTaskUseCase = MockDeleteTaskUseCase();
      taskBloc = TaskBloc(fetchTaskUseCase, addTaskUseCase, deleteTaskUseCase);
    });

    test('Test Initial State', () {
      expect(taskBloc.state, TaskInitial());
    });

    test('Test LoadTasks and UseCase', () async {
      final tasks = [const TaskModel(title: "title", id: "1")];
      when(() => fetchTaskUseCase.getTasks())
          .thenAnswer((_) => Future.value(tasks));

      taskBloc.add(LoadTaskEvent());

      await expectLater(
        taskBloc.stream,
        emitsInOrder([
          TaskLoadingState(),
          TaskLoadedState(tasks: tasks),
        ]),
      );
    });
    test('Test Add Tasks and UseCase', () async {
      final initialTasks = [const TaskModel(id: '1', title: 'Task 1')];
      const taskToAdd = TaskModel(id: '2', title: 'Task 2');
      final updatedTasks = [...initialTasks, taskToAdd];

      when(() => addTaskUseCase.addTask(taskToAdd)).thenAnswer((_) async {});
      when(() => fetchTaskUseCase.getTasks())
          .thenAnswer((_) async => updatedTasks);

      taskBloc.add(const AddTaskEvent(taskToAdd));

      await expectLater(
        taskBloc.stream,
        emitsInOrder([
          TaskLoadingState(),
          TaskLoadedState(tasks: updatedTasks),
        ]),
      );
    });
    test('Test Delete Tasks and UseCase', () async {
      final initialTasks = [
        const TaskModel(id: '1', title: 'Task 1'),
        const TaskModel(id: '2', title: 'Task 2')
      ];
      const taskToDelete = TaskModel(id: '1', title: 'Task 1');
      final remainingTasks = [const TaskModel(id: '2', title: 'Task 2')];

      when(() => deleteTaskUseCase.deleteTask(taskToDelete))
          .thenAnswer((_) async {});
      when(() => fetchTaskUseCase.getTasks())
          .thenAnswer((_) async => remainingTasks);

      taskBloc.add(const DeleteTaskEvent(taskToDelete));

      await expectLater(
        taskBloc.stream,
        emitsInOrder([
          TaskLoadingState(),
          TaskLoadedState(tasks: remainingTasks),
        ]),
      );
    });
  });
}
