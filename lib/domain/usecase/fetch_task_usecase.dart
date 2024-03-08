import 'package:task_manager_app/data/model/task_model.dart';
import 'package:task_manager_app/domain/repository/task_repository.dart';

class FetchTaskUseCase {
  late final TaskRepository _taskRepository;

  FetchTaskUseCase(this._taskRepository);

  Future<List<TaskModel>> getTasks() async {
    return await _taskRepository.fetchTasks();
  }
}
