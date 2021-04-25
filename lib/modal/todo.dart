import 'package:flutter/material.dart';

class TodoModal {
  // declare variable
  String _taskName = "";
  String _taskDescription = "";

  // getter and setter
  String get_taskName() => _taskName;
  String get_taskDescription() => _taskDescription;

  void set_taskName(String value) {
    _taskName = value;
  }

  void set_taskDescription(String value) {
    _taskDescription = value;
  }
}
