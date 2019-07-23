import 'package:flutter/material.dart';
import 'colors/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODUO',
      theme: ThemeData(
        primarySwatch: primary,
        primaryColorLight: Color.fromRGBO(237, 237, 237, 1),
        primaryColorDark: Color.fromRGBO(30, 30, 30, 1),
        accentColor: Color.fromRGBO(232, 58, 96, 1),
        unselectedWidgetColor: Color.fromRGBO(89, 89, 89, 1),
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: appBar(context),
      ),
      body: Container(
        color: Theme.of(context).primaryColorDark,
        child: TodoList(),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(10.0),
        child: Container(
          height: 10,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0, 1],
              colors: [
                Colors.red,
                Colors.pinkAccent,
              ],
            ),
          ),
        ),
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
                  children: dateTitle(context),
                ),
                Center(
                  child: Container(
                    height: 40,
                    child: FloatingActionButton(
                      onPressed: () {},
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

  List<Widget> dateTitle(BuildContext context) {
    return <Widget>[
      Text(
        "26 January",
        style: TextStyle(
          fontWeight: FontWeight.w100,
          fontSize: 30,
          color: Theme.of(context).primaryColorLight,
        ),
      ),
      Text(
        "8 OPEN TASKS",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).primaryColorLight,
        ),
      ),
    ];
  }
}

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

class Task {
  Task(this.info, this.datetime) {}
  bool isDone = false;
  String info;
  DateTime datetime;

  void toggleDone() {
    isDone = !isDone;
  }
}
