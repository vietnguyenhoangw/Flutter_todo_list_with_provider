import 'package:flutter/material.dart';
import 'package:todolist_with_provider/modal/todo.dart';

class TodoListModal with ChangeNotifier {
  List<TodoModal> _todoList = [];

  List<TodoModal> get_todoList() => _todoList;

  void set_todoList(List<TodoModal> value) {
    _todoList = value;
    notifyListeners();
  }

  void add_todo_item(TodoModal todoTask) {
    _todoList.add(todoTask);
    notifyListeners();
  }
}
