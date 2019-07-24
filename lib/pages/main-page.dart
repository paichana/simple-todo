import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/date-appbar.dart';
import '../widgets/todo-list.dart';
import '../providers/tasks.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (ctx) => TasksProvider(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: new DateAppBar(context: context),
        ),
        body: Container(
          color: Theme.of(context).primaryColorDark,
          child: TodoList(),
        ),
      ),
    );
  }
}
