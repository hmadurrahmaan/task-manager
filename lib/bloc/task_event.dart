part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTaskEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final TaskModel taskModel;

  const AddTaskEvent(this.taskModel);

  @override
  List<Object> get props => [taskModel];
}

class DeleteTaskEvent extends TaskEvent {
  final TaskModel taskModel;

  const DeleteTaskEvent(this.taskModel);

  @override
  List<Object> get props => [taskModel];
}
