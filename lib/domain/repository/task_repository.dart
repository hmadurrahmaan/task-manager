import 'package:task_manager_app/data/data_source/shared_pref_source.dart';
import 'package:task_manager_app/data/model/task_model.dart';

class TaskRepository {
  final SharedPrefDataSource _sharedPrefDataSource;

  TaskRepository(this._sharedPrefDataSource);

  Future<void> addTask(TaskModel task) async {
    await _sharedPrefDataSource.addTask(task);
  }

  Future<void> deleteTask(TaskModel task) async {
    await _sharedPrefDataSource.deleteTask(task.id);
  }

  Future<List<TaskModel>> fetchTasks() async {
    return await _sharedPrefDataSource.fetchTasks();
  }
}
