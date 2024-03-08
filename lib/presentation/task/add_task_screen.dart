import 'package:flutter/material.dart';
import 'package:task_manager_app/bloc/task_bloc.dart';
import 'package:task_manager_app/core/utils/locator.dart';
import 'package:task_manager_app/data/model/task_model.dart';
import 'package:uuid/uuid.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addTaskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      title: const Text("Add Task"),
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            controller: _addTaskController,
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a task title';
              }
              return null;
            },
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final task = TaskModel(
                id: const Uuid().v4(),
                title: _addTaskController.text,
              );
              locator<TaskBloc>().add(AddTaskEvent(task));
              Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor),
          child: const Text(
            'Add',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
