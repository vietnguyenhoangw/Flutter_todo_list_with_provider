import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddTaskHeader extends StatefulWidget {
  final textFieldController;
  final voidCallback;

  AddTaskHeader({this.textFieldController, this.voidCallback});

  @override
  _AddTaskHeaderState createState() => _AddTaskHeaderState();
}

class _AddTaskHeaderState extends State<AddTaskHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Expanded(
            flex: 0,
            child: Container(
              margin: const EdgeInsets.only(top: 20.0),
              alignment: Alignment.topCenter,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: widget.textFieldController,
                      decoration: InputDecoration(
                        hintText: 'Add task title',
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        child: Text('Add'),
                        onPressed: () => widget.voidCallback(),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.yellow,
                        ),
                      ))
                ],
              ),
            )));
  }
}
