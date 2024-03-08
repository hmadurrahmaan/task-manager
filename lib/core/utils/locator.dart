import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/bloc/task_bloc.dart';
import 'package:task_manager_app/domain/repository/task_repository.dart';
import 'package:task_manager_app/domain/usecase/add_task_usecase.dart';
import 'package:task_manager_app/domain/usecase/delete_task_usecase.dart';
import 'package:task_manager_app/domain/usecase/fetch_task_usecase.dart';

import '../../data/data_source/shared_pref_source.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  // SharedPreference;
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  // BLoCs
  locator.registerLazySingleton<TaskBloc>(
    () => TaskBloc(locator(), locator(), locator())..add(LoadTaskEvent()),
  );

  // UseCases
  locator.registerLazySingleton<FetchTaskUseCase>(
      () => FetchTaskUseCase(locator()));
  locator
      .registerLazySingleton<AddTaskUseCase>(() => AddTaskUseCase(locator()));
  locator.registerLazySingleton<DeleteTaskUseCase>(
      () => DeleteTaskUseCase(locator()));

  // Repositories
  locator.registerLazySingleton(() => TaskRepository(locator()));

  // DataSources
  locator.registerLazySingleton(() => SharedPrefDataSource(sharedPreferences));
}
