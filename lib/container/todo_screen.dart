import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todolist_with_provider/localization/app_localizations.dart';
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
              child: Column(
            children: [
              AddTaskHeader(
                buttonTitle: todoListVM.isEditMode
                    ? AppLocalizations.of(context).translate("done")
                    : AppLocalizations.of(context).translate("add"),
                textFieldController: widget.taskInputController,
                voidCallback: () => todoListVM.onPressAddItem(
                    widget.taskInputController, newContext),
              ),
              ListContent(scrollController: widget._scrollController),
              Footer(),
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
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.amber[300], spreadRadius: 3),
        ],
      ),
      padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
      margin: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              '${listItem[index].get_taskName()}',
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () => Provider.of<TodoViewModal>(context, listen: false)
                  .editItem(listItem[index]),
              child: Icon(
                Icons.edit,
                color: Colors.black38,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () => Provider.of<TodoViewModal>(context, listen: false)
                  .removeItem(listItem[index]),
              child: Icon(
                Icons.delete,
                color: Colors.black38,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                Provider.of<TodoViewModal>(context).isEditMode
                    ? AppLocalizations.of(context)
                        .translate("editTask")
                        .toUpperCase()
                    : AppLocalizations.of(context)
                        .translate("addTask")
                        .toUpperCase(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Provider.of<TodoViewModal>(context).isEditMode
              ? Expanded(
                  flex: 0,
                  child: Container(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: GestureDetector(
                      onTap: () =>
                          Provider.of<TodoViewModal>(context, listen: false)
                              .turnOffEditMode(),
                      child: Icon(
                        Icons.close,
                        color: Colors.black38,
                      ),
                    ),
                  ))
              : Container(),
        ],
      ),
    );
  }
}
