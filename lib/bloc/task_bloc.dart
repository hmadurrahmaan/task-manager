import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/domain/usecase/add_task_usecase.dart';
import 'package:task_manager_app/domain/usecase/delete_task_usecase.dart';

import '../data/model/task_model.dart';
import '../domain/usecase/fetch_task_usecase.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final FetchTaskUseCase _fetchTaskUseCase;
  final AddTaskUseCase _addTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;

  List<TaskModel> tasks = [];

  TaskBloc(
    this._fetchTaskUseCase,
    this._addTaskUseCase,
    this._deleteTaskUseCase,
  ) : super(TaskInitial()) {
    on<LoadTaskEvent>((event, emit) async {
      emit(TaskLoadingState());
      tasks = await _fetchTaskUseCase.getTasks();
      emit(TaskLoadedState(tasks: tasks));
    });
    on<AddTaskEvent>((event, emit) async {
      emit(TaskLoadingState());
      await _addTaskUseCase.addTask(event.taskModel);
      tasks = await _fetchTaskUseCase.getTasks();

      emit(TaskLoadedState(tasks: tasks));
    });
    on<DeleteTaskEvent>((event, emit) async {
      emit(TaskLoadingState());
      await _deleteTaskUseCase.deleteTask(event.taskModel);
      tasks = await _fetchTaskUseCase.getTasks();
      emit(TaskLoadedState(tasks: tasks));
    });
  }
}
