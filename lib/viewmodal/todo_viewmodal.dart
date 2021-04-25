import 'package:flutter/cupertino.dart';
import 'package:todolist_with_provider/modal/todo.dart';
import 'package:todolist_with_provider/modal/todo_list.dart';

class TodoViewModal extends ChangeNotifier {
  TodoListModal todoListModal = new TodoListModal();

  List<TodoModal> listTodo = [];

  void addNewTodoToList(
    TextEditingController taskInputController,
    ScrollController scrollController,
    BuildContext context,
  ) {
    TodoModal newTodo = new TodoModal();
    newTodo.set_taskName(taskInputController.text);
    todoListModal.add_todo_item(newTodo);
    getListTodo();
    taskInputController.text = "";
    scrollController?.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
    FocusScope.of(context).requestFocus(FocusNode());
    notifyListeners();
  }

  void getListTodo() {
    List<TodoModal> listTodoModal = todoListModal.get_todoList();
    this.listTodo = listTodoModal;
    notifyListeners();
  }
}
