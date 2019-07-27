import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/date-appbar.dart';
import '../widgets/todo-list.dart';
import '../providers/tasks.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final taskProvider = TasksProvider();
  @override
  void initState() {
    taskProvider.loadTask();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (ctx) => taskProvider,
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
