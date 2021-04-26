import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist_with_provider/modal/todo.dart';
import 'package:todolist_with_provider/modal/todo_list.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TodoViewModal extends ChangeNotifier {
  // init modal
  TodoListModal todoListModal = new TodoListModal();

  // decrease variance
  List<TodoModal> listTodo = [];

  void getListTodo() {
    List<TodoModal> listTodoModal = todoListModal.get_todoList();
    this.listTodo = listTodoModal;
    notifyListeners();
  }

  void addNewItem(
    TextEditingController taskInputController,
    BuildContext context,
  ) {
    if (taskInputController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Task title is empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black38,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      TodoModal newTodo = new TodoModal();
      int generateId = todoListModal.get_todoList_size() + 1;
      newTodo.set_id(generateId.toString());
      newTodo.set_taskName(taskInputController.text);
      todoListModal.add_todo_item(newTodo);
      getListTodo();
      taskInputController.text = "";
      notifyListeners();
    }
  }

  void removeItem(TodoModal todoModal) {
    String itemId = todoModal.get_id();
    List<TodoModal> listTodoModal = todoListModal.get_todoList();
    listTodoModal.removeWhere((item) => item.get_id() == itemId);
    notifyListeners();
  }
}
