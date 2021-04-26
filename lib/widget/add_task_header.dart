import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddTaskHeader extends StatefulWidget {
  final textFieldController;
  final voidCallback;
  final buttonTitle;

  AddTaskHeader(
      {this.textFieldController,
      this.voidCallback,
      this.buttonTitle = "btnTitle"});

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
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              margin: const EdgeInsets.only(top: 40.0),
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
                        child: Text(widget.buttonTitle.toString()),
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
