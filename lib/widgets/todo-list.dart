import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tasks.dart';

class TodoList extends StatefulWidget {
  TodoList(this.currentDate);
  final DateTime currentDate;
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  bool testBool = false;

  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<TasksProvider>(context);
    final task = taskData.getTasks(widget.currentDate);
    final done = taskData.getDone(widget.currentDate);
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
        Padding(
          padding: const EdgeInsets.only(top: 35),
          child: ListView.builder(
              itemCount: task.length + done.length,
              itemBuilder: (context, i) {
                double margin = 0;

                bool isDone = (i > task.length - 1);
                int j = i - task.length;

                return Dismissible(
                  direction: DismissDirection.horizontal,
                  key: Key(
                      '${i.toString()}${isDone ? done[j].info : task[i].info}${isDone ? done[j].datetime.toString() : task[i].datetime.toString()}'),
                  onDismissed: (direction) {
                    taskData.removeTaskIndex(widget.currentDate, i);
                  },
                  background: Container(
                    color: Theme.of(context).primaryColor,
                    child: Center(
                      child: Icon(
                        Icons.delete,
                        size: 70,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  child: Container(
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
                                        ? Theme.of(context)
                                            .unselectedWidgetColor
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
                                          ? Theme.of(context)
                                              .unselectedWidgetColor
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
                            activeColor:
                                Theme.of(context).unselectedWidgetColor,
                            checkColor: Theme.of(context).primaryColorDark,
                            value: isDone,
                            onChanged: (bool val) {
                              setState(() {
                                if (!isDone) {
                                  taskData.taskDone(widget.currentDate, i);
                                } else {
                                  taskData.taskUndone(widget.currentDate, j);
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
