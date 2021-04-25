// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_with_provider/common/theme.dart';
import 'package:todolist_with_provider/container/todo_screen.dart';
import 'package:todolist_with_provider/modal/todo_list.dart';
import 'package:todolist_with_provider/viewmodal/todo_viewmodal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TodoViewModal()),
        ],
        child: MaterialApp(
          theme: appTheme,
          initialRoute: '/',
          routes: {'/': (context) => TodoScreen()},
        ));
  }
}
