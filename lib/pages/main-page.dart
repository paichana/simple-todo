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
  final pageController = PageController(initialPage: 300);

  @override
  void initState() {
    taskProvider.loadTask(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        builder: (ctx) => taskProvider,
        child: PageView.builder(
          controller: pageController,
          itemBuilder: (context, i) {
            i = i - 300;
            DateTime currentDay =
                taskProvider.currentDate.add(Duration(days: i));
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(100.0),
                child: DateAppBar(
                  context: context,
                  currentDate: currentDay,
                ),
              ),
              body: Container(
                color: Theme.of(context).primaryColorDark,
                child: TodoList(currentDay),
              ),
            );
          },
        ));
  }
}
