import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';

import '../providers/tasks.dart';
import '../widgets/progress-bar.dart';

class DateAppBar extends StatefulWidget {
  final BuildContext context;
  final DateTime currentDate;

  DateAppBar({
    Key key,
    @required this.context,
    @required this.currentDate,
  }) : super(key: key);

  @override
  _DateAppBarState createState() => _DateAppBarState();
}

class _DateAppBarState extends State<DateAppBar> {
  var dateFormatter = DateFormat('dd EEEE');
  var dateFormatter2 = DateFormat('MMMM y');

  final timeFormat = DateFormat("HH:mm");
  final infoController = TextEditingController();
  final datetimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<TasksProvider>(context);
    final task = taskData.getTasks(widget.currentDate);
    final done = taskData.getDone(widget.currentDate);

    final progress = (done.length + task.length > 0)
        ? done.length / (task.length + done.length)
        : 0.0;

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
                      dateFormatter.format(widget.currentDate),
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 30,
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          '${dateFormatter2.format(widget.currentDate)}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).primaryColorLight,
                          ),
                        ),
                        Container(
                          width: 20,
                        ),
                        Text(
                          '${task.length} OPEN TASKS',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    height: 40,
                    child: FloatingActionButton(
                      onPressed: () async {
                        await buildShowBottomSheet(context, taskData);
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

  Future<PersistentBottomSheetController> buildShowBottomSheet(
      BuildContext context, TasksProvider tp) async {
    return showBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Theme.of(context).unselectedWidgetColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Container(
                height: 300,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextField(
                        autocorrect: true,
                        autofocus: true,
                        controller: infoController,
                        decoration: InputDecoration(
                            hintText: "Go shopping....",
                            labelText: "TODOs",
                            hintStyle: TextStyle(fontSize: 20),
                            labelStyle: TextStyle(fontSize: 20)),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Theme.of(context).accentColor,
                        child: Text('TIME DUE'),
                        onPressed: () async {
                          var tod = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );

                          DateTime c = DateTime(
                            widget.currentDate.year,
                            widget.currentDate.month,
                            widget.currentDate.day,
                            tod.hour,
                            tod.minute,
                          );

                          tp.addTask(
                              widget.currentDate, Task(infoController.text, c));
                          infoController.clear();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
