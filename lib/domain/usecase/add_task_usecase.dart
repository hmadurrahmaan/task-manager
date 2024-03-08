import 'package:task_manager_app/data/model/task_model.dart';
import 'package:task_manager_app/domain/repository/task_repository.dart';

class AddTaskUseCase {
  late final TaskRepository _taskRepository;

  AddTaskUseCase(this._taskRepository);

  Future<void> addTask(TaskModel task) async {
    await _taskRepository.addTask(task);
  }
}
