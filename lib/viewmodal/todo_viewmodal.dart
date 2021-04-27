import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist_with_provider/modal/todo.dart';
import 'package:todolist_with_provider/utils/application_functions.dart';
import 'package:todolist_with_provider/utils/share_reference_functions.dart';

class TodoViewModal extends ChangeNotifier {
  // init modal
  TextEditingController taskInputController;

  // decrease variance
  List<TodoModal> listTodo = [];
  bool isEditMode = false;
  TodoModal editTodoItem;

  void setController(
    TextEditingController taskInputController,
  ) {
    this.taskInputController = taskInputController;
  }

  void getListTodo() async {
    String todoListFromLocal = await getStringFromLocal("localTodoList");
    var todoListJson = json.decode(todoListFromLocal);
    List<TodoModal> listTodoFromJson = todoListJson
        .map<TodoModal>((tagJson) => TodoModal.fromJson(tagJson))
        .toList();
    this.listTodo = listTodoFromJson;
    notifyListeners();
  }

  void onPressAddItem(
    TextEditingController taskInputController,
    BuildContext context,
  ) async {
    if (taskInputController.text.isEmpty) {
      showToast("Task title is empty");
    } else {
      // -- EDIT TASK MODE --
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

        String jsonListTodo = jsonEncode(this.listTodo);
        bool saveToLocal =
            await saveStringToLocal("localTodoList", jsonListTodo);
        if (saveToLocal) {
          this.isEditMode = false;
          taskInputController.text = "";
          getListTodo();
          notifyListeners();
          showToast("Edit task success");
        } else {
          showToast("Edit task fail");
        }
      } else {
        // -- ADD TASK MODE --
        // create new todo task
        TodoModal newTodo = new TodoModal();
        int generateId = this.listTodo.length + 1;
        newTodo.set_id(generateId.toString());
        newTodo.set_taskName(taskInputController.text);

        // add new todo task into list
        // after add, convert to json and add to local storage
        this.listTodo.add(newTodo);
        String jsonListTodo = jsonEncode(this.listTodo);
        bool saveToLocal =
            await saveStringToLocal("localTodoList", jsonListTodo);

        if (saveToLocal) {
          this.isEditMode = false;
          taskInputController.text = "";
          getListTodo();
          notifyListeners();
          showToast("Add task success");
        } else {
          showToast("Add task fail");
        }
      }
    }
    FocusScope.of(context).unfocus();
  }

  void removeItem(TodoModal todoModal) async {
    String itemId = todoModal.get_id();
    this.listTodo.removeWhere((item) => item.get_id() == itemId);
    String jsonListTodo = jsonEncode(this.listTodo);
    bool saveToLocal = await saveStringToLocal("localTodoList", jsonListTodo);
    saveToLocal
        ? showToast("Remove task success")
        : showToast("Remove task fail");
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
