import 'package:flutter/material.dart';
import 'package:todolist_with_provider/modal/todo.dart';

class TodoListModal {
  List<TodoModal> _todoList = [];
  List<TodoModal> get_todoList() => _todoList;

  void set_todoList(List<TodoModal> value) {
    _todoList = value;
  }

  void add_todo_item(TodoModal todoTask) {
    _todoList.insert(0, todoTask);
  }

  int get_todoList_size() {
    return _todoList.length;
  }
}
