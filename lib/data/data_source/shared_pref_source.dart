import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/data/model/task_model.dart';

class SharedPrefDataSource {
  final SharedPreferences _sharedPreferences;

  SharedPrefDataSource(this._sharedPreferences);

  Future<List<TaskModel>> fetchTasks() async {
    final jsonString = _sharedPreferences.getString('tasks') ?? '[]';
    final tasks = jsonDecode(jsonString) as List;
    return tasks.map((map) => TaskModel.fromJson(map)).toList();
  }

  Future<void> addTask(TaskModel task) async {
    final tasks = await fetchTasks();
    tasks.add(task);
    await _sharedPreferences.setString('tasks', jsonEncode(tasks));
  }

  Future<void> deleteTask(String id) async {
    final tasks = await fetchTasks();
    tasks.removeWhere((task) => task.id == id);
    await _sharedPreferences.setString('tasks', jsonEncode(tasks));
  }
}
