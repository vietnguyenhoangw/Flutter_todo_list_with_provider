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
}
