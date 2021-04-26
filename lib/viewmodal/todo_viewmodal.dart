import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist_with_provider/modal/todo.dart';
import 'package:todolist_with_provider/modal/todo_list.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TodoViewModal extends ChangeNotifier {
  // init modal
  TodoListModal todoListModal = new TodoListModal();
  TextEditingController taskInputController;

  // decrease variance
  List<TodoModal> listTodo = [];
  bool isEditMode = false;
  TodoModal editTodoItem;

  void getListTodo() {
    List<TodoModal> listTodoModal = todoListModal.get_todoList();
    this.listTodo = listTodoModal;
    notifyListeners();
  }

  void onPressAddItem(
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
      if (this.isEditMode) {
        TodoModal newTodo = new TodoModal();
        newTodo.set_id(editTodoItem.get_id());
        newTodo.set_taskName(taskInputController.text);

        for (final item in this.listTodo) {
          if (item.get_id() == newTodo.get_id()) {
            final index = this.listTodo.indexOf(item);
            this.listTodo.removeAt(index);
            this.listTodo.insert(index, newTodo);
          }
        }
      } else {
        TodoModal newTodo = new TodoModal();
        int generateId = todoListModal.get_todoList_size() + 1;
        newTodo.set_id(generateId.toString());
        newTodo.set_taskName(taskInputController.text);
        todoListModal.add_todo_item(newTodo);
      }

      this.taskInputController = taskInputController;
      this.isEditMode = false;
      taskInputController.text = "";
      getListTodo();
      notifyListeners();
    }
  }

  void removeItem(TodoModal todoModal) {
    String itemId = todoModal.get_id();

    List<TodoModal> listTodoModal = todoListModal.get_todoList();
    listTodoModal.removeWhere((item) => item.get_id() == itemId);

    notifyListeners();
  }

  void editItem(TodoModal todoModal) {
    this.editTodoItem = todoModal;
    this.isEditMode = true;
    this.taskInputController.text = todoModal.get_taskName().toString();
    notifyListeners();
  }

  void turnOffEditMode() {
    this.isEditMode = false;
    this.taskInputController.text = "";
    notifyListeners();
  }
}
