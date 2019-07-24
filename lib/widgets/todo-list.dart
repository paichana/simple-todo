import 'package:flutter/material.dart';
import '../models/task.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  bool testBool = false;
  var task = [
    Task("Buy happiness", DateTime(2019, DateTime.november, 9, 13, 30)),
    Task("Do homework", DateTime(2019, DateTime.november, 9, 9, 45)),
    Task("Freelance work from John",
        DateTime(2019, DateTime.november, 9, 10, 0)),
    Task("Freelance work from Chris",
        DateTime(2019, DateTime.november, 9, 11, 30)),
    Task("Date with Jeniffer Lawrence",
        DateTime(2019, DateTime.november, 10, 18, 0)),
    Task("Buy Jordans", DateTime(2019, DateTime.november, 9, 19, 0)),
    Task("Delete Photoshop", DateTime(2019, DateTime.november, 9, 20, 0)),
    Task("Create TODO list", DateTime(2019, DateTime.november, 9, 21, 0)),
    Task("Jog", DateTime(2019, DateTime.november, 9, 22, 0)),
    Task("Buy KFC", DateTime(2019, DateTime.november, 9, 21, 0)),
    Task("Sleep well", DateTime(2019, DateTime.november, 9, 5, 0))
  ];
  var done = <Task>[];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 24.5),
          child: Container(
            height: double.infinity,
            width: 0.2,
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        ListView.builder(
            itemCount: task.length + done.length,
            itemBuilder: (context, i) {
              double margin = 0;
              if (i == 0) {
                margin = 35;
              }

              bool isDone = (i > task.length - 1);
              int j = i - task.length;

              return Container(
                margin: EdgeInsets.only(top: margin),
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: CircleAvatar(
                            radius: 5.0,
                            backgroundColor: isDone
                                ? Theme.of(context).unselectedWidgetColor
                                : Theme.of(context).accentColor,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              isDone
                                  ? '${done[j].datetime.hour.toString().padLeft(2, '0')}:${done[j].datetime.minute.toString().padLeft(2, '0')}'
                                  : '${task[i].datetime.hour.toString().padLeft(2, '0')}:${task[i].datetime.minute.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                color: isDone
                                    ? Theme.of(context).unselectedWidgetColor
                                    : Theme.of(context).primaryColorLight,
                                fontSize: 10.0,
                              ),
                            ),
                            Text(
                              isDone
                                  ? done[j].info.toString()
                                  : task[i].info.toString(),
                              style: TextStyle(
                                  color: isDone
                                      ? Theme.of(context).unselectedWidgetColor
                                      : Theme.of(context).primaryColorLight,
                                  fontSize: 20.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: 50,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(1000),
                        color: Theme.of(context).unselectedWidgetColor,
                      ),
                      child: Checkbox(
                        activeColor: Theme.of(context).unselectedWidgetColor,
                        checkColor: Theme.of(context).primaryColorDark,
                        value: isDone,
                        onChanged: (bool val) {
                          setState(() {
                            if (!isDone) {
                              Task temp = task[i];
                              task.removeAt(i);
                              done.add(temp);
                            } else {
                              Task temp = done[j];
                              done.removeAt(j);
                              task.add(temp);
                            }
                            task.sort(
                                (a, b) => a.datetime.compareTo(b.datetime));
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }
}
