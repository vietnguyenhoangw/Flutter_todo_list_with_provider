import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todolist_with_provider/modal/todo.dart';
import 'package:todolist_with_provider/modal/todo_list.dart';
import 'package:todolist_with_provider/widget/add_task_header.dart';

class TodoScreen extends StatelessWidget {
  final addTaskController = TextEditingController();

  void onPressAddTask(context) {
    final todoListModal = Provider.of<TodoListModal>(context, listen: false);
    TodoModal newTodo = new TodoModal();
    if (addTaskController.text.length > 0) {
      newTodo.set_taskName(addTaskController.text);
    } else {
      newTodo.set_taskName("Empty name task");
    }
    todoListModal.add_todo_item(newTodo);
    addTaskController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              AddTaskHeader(
                textFieldController: addTaskController,
                voidCallback: () => onPressAddTask(context),
              ),
              ListContent()
            ],
          )),
    );
  }
}

class ListContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoListModal = Provider.of<TodoListModal>(context);
    var todoList = todoListModal.get_todoList();

    return Expanded(
        flex: 1,
        child: Container(
          alignment: Alignment.topCenter,
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                return TodoItem(
                  listItem: todoList,
                  index: index,
                );
              }),
        ));
  }
}

class TodoItem extends StatelessWidget {
  final List<TodoModal> listItem;
  final int index;

  TodoItem({this.index, this.listItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15.0),
      margin: const EdgeInsets.only(bottom: 15.0),
      height: 50,
      color: Colors.amber[300],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            '${listItem[index].get_taskName()}',
          ),
        ],
      ),
    );
  }
}
