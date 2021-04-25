import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todolist_with_provider/modal/todo.dart';
import 'package:todolist_with_provider/viewmodal/todo_viewmodal.dart';
import 'package:todolist_with_provider/widget/add_task_header.dart';

class TodoScreen extends StatefulWidget {
  TextEditingController taskInputController = new TextEditingController();
  ScrollController _scrollController = new ScrollController();

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TodoViewModal>(context, listen: false).getListTodo();
  }

  @override
  Widget build(BuildContext context) {
    final todoListVM = Provider.of<TodoViewModal>(context);
    return Scaffold(
      body: Builder(
        builder: (BuildContext newContext) {
          return Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  AddTaskHeader(
                    textFieldController: widget.taskInputController,
                    voidCallback: () => todoListVM.addNewTodoToList(
                        widget.taskInputController,
                        widget._scrollController,
                        newContext),
                  ),
                  ListContent(scrollController: widget._scrollController)
                ],
              ));
        },
      ),
    );
  }
}

class ListContent extends StatelessWidget {
  ScrollController scrollController;

  ListContent({this.scrollController});

  @override
  Widget build(BuildContext context) {
    final todoListVM = Provider.of<TodoViewModal>(context);
    return Expanded(
        flex: 1,
        child: Container(
          alignment: Alignment.topCenter,
          child: ListView.builder(
              controller: scrollController,
              physics: BouncingScrollPhysics(),
              itemCount: todoListVM.listTodo.length,
              itemBuilder: (context, index) {
                return TodoItem(
                  listItem: todoListVM.listTodo,
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
