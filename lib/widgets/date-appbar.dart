import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/tasks.dart';
import '../widgets/todo-dialog.dart';
import '../widgets/progress-bar.dart';

class DateAppBar extends StatefulWidget {
  final BuildContext context;
  DateTime selectedDate;

  DateAppBar({
    Key key,
    @required this.context,
  }) : super(key: key) {
    selectedDate = DateTime.now();
  }

  @override
  _DateAppBarState createState() => _DateAppBarState();
}

class _DateAppBarState extends State<DateAppBar> {
  var dateFormatter = DateFormat('dd EEEE');
  final timeFormat = DateFormat("HH:mm");

  String dateString;

  @override
  void initState() {
    super.initState();
    dateString = dateFormatter.format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<TasksProvider>(context);
    final task = taskData.tasks;
    final done = taskData.done;

    final progress = done.length / (task.length + done.length);

    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(10.0),
        child: ProgressBar(progress),
      ),
      flexibleSpace: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      dateString,
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 30,
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                    Text(
                      '${task.length} OPEN TASKS',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    height: 40,
                    child: FloatingActionButton(
                      onPressed: () {
                        _showDialog(taskData);
                      },
                      backgroundColor: Theme.of(context).accentColor,
                      foregroundColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        "+",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(TasksProvider taskData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var alertDialog =
            new AddTodoDialog(timeFormat: timeFormat, taskData: taskData);
        return alertDialog;
      },
    );
  }
}
