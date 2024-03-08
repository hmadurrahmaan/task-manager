import 'package:flutter/material.dart';
import 'package:task_manager_app/core/utils/locator.dart';
import 'package:task_manager_app/data/model/task_model.dart';

import '../../../bloc/task_bloc.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;

  const TaskItem({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        visualDensity: const VisualDensity(vertical: 2),
        title: Text(task.title, style: Theme.of(context).textTheme.titleMedium),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.redAccent),
          onPressed: () => showDeleteDialog(context),
        ),
      ),
    );
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: Text('Are you sure you want to delete "${task.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              locator<TaskBloc>().add(DeleteTaskEvent(task));
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
