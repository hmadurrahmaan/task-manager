import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final String id;
  final String title;

  const TaskModel({required this.title, required this.id});

  @override
  List<Object> get props => [id, title];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
    );
  }
}
