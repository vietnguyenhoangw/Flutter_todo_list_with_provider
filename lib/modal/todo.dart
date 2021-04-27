import 'package:flutter/material.dart';

class TodoModal {
  // declare variable
  String _id = "";
  String _taskName = "";
  String _taskDescription = "";

  // getter and setter
  String get_id() => _id;
  String get_taskName() => _taskName;
  String get_taskDescription() => _taskDescription;

  TodoModal();

  @override
  String toString() {
    return 'TodoModal{_id: $_id, _taskName: $_taskName, _taskDescription: $_taskDescription}';
  }

  void set_id(String value) {
    _id = value;
  }

  void set_taskName(String value) {
    _taskName = value;
  }

  void set_taskDescription(String value) {
    _taskDescription = value;
  }

  Map toJson() => {
        'id': _id,
        'taskName': _taskName,
        'taskDescription': _taskDescription,
      };

  factory TodoModal.fromJson(dynamic json) {
    TodoModal todoModal = new TodoModal();
    todoModal.set_id(json['id'] as String);
    todoModal.set_taskName(json['taskName'] as String);
    todoModal.set_taskDescription(json['taskDescription']);
    return todoModal;
  }
}
