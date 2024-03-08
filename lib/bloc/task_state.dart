part of 'task_bloc.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

final class TaskInitial extends TaskState {
  @override
  List<Object> get props => [];
}

final class TaskLoadingState extends TaskState {
  @override
  List<Object> get props => [];
}

final class TaskLoadedState extends TaskState {
  final List<TaskModel> tasks;
  const TaskLoadedState({required this.tasks});
  @override
  List<Object> get props => [tasks];
}
