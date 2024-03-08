import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/bloc/task_bloc.dart';
import 'package:task_manager_app/core/utils/locator.dart';
import 'package:task_manager_app/presentation/task/add_task_screen.dart';
import 'package:task_manager_app/presentation/task/widget/task_item.dart';

class TaskListingScreen extends StatefulWidget {
  TaskBloc taskBloc;
   TaskListingScreen({Key? key,required this.taskBloc}) : super(key: key);

  @override
  State<TaskListingScreen> createState() => _TaskListingScreenState();
}

class _TaskListingScreenState extends State<TaskListingScreen> {
  late TaskBloc _taskBloc;

  @override
  void initState() {
    super.initState();
    _taskBloc=widget.taskBloc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: const Text(
          "Task Manager",
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: floatingButton(),
      body: BlocBuilder<TaskBloc, TaskState>(
        bloc: _taskBloc,
        builder: (context, state) {
          if (state is TaskLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TaskLoadedState) {
            if (state.tasks.isEmpty) {
              return const Center(child: Text("No Tasks Added"));
            }
            return ListView.builder(
              itemCount: state.tasks.length,
              padding: const EdgeInsets.only(top: 16),
              itemBuilder: (context, index) {
                return TaskItem(task: state.tasks[index]);
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget floatingButton() {
    return FloatingActionButton.extended(
      label: const Text('Add'),
      icon: const Icon(Icons.add),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => const AddTaskScreen(),
        );
      },
    );
  }
}
