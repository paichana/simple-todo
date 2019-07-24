import 'package:flutter/material.dart';

import '../widgets/date-appbar.dart';
import '../widgets/todo-list.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: new DateAppBar(context: context),
      ),
      body: Container(
        color: Theme.of(context).primaryColorDark,
        child: TodoList(),
      ),
    );
  }
}
