import 'package:task_manager_app/data/model/task_model.dart';
import 'package:task_manager_app/domain/repository/task_repository.dart';

class DeleteTaskUseCase {
  late final TaskRepository _taskRepository;

  DeleteTaskUseCase(this._taskRepository);

  Future<void> deleteTask(TaskModel task) async {
    await _taskRepository.deleteTask(task);
  }
}
