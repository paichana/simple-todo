import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/task.dart';

class TasksProvider with ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> _done = [];
  Map<String, TodoList> td = Map();

  DateFormat keyFormatter = DateFormat("yMd");

  DateTime currentDate;

  TasksProvider() {
    currentDate = DateTime.now();
  }

  loadTask(DateTime dt) async {
    String key = keyFormatter.format(dt);

    if (td.containsKey(key)) {
      _tasks = td[key].tasks;
      _done = td[key].done;
      return;
    }

    TodoList temptd = TodoList();
    await SharedPreferences.getInstance().then((prefs) {
      List<String> pdone = prefs.getStringList('done_${key}') ?? [];

      if (pdone.length > 0) {
        temptd.done = pdone.map((t) {
          Map<String, dynamic> jsonDone = jsonDecode(t);
          return Task(jsonDone["info"], DateTime.parse(jsonDone["datetime"]));
        }).toList();
      } else {
        temptd.done = [];
      }

      List<String> ptask = prefs.getStringList("tasks") ?? [];

      if (ptask.length > 0) {
        temptd.tasks = ptask.map((t) {
          Map<String, dynamic> jsonDone = jsonDecode(t);
          return Task(jsonDone["info"], DateTime.parse(jsonDone["datetime"]));
        }).toList();
      } else {
        temptd.tasks = [];
      }
    });

    td[key] = temptd;
    notifyListeners();
  }

  saveTask(DateTime dt) async {
    String key = keyFormatter.format(dt);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'done_$key', td[key].done.map((t) => t.itemToJsonString()).toList());
    prefs.setStringList(
        'tasks_$key', td[key].tasks.map((t) => t.itemToJsonString()).toList());
  }

  List<Task> getTasks(DateTime dt) {
    String key = keyFormatter.format(dt);
    if (td.containsKey(key)) {
      return td[key].tasks;
    } else {
      td[key] = TodoList();
      return td[key].tasks;
    }
  }

  List<Task> getDone(DateTime dt) {
    String key = keyFormatter.format(dt);
    if (td.containsKey(key)) {
      return td[key].done;
    } else {
      td[key] = TodoList();
      return td[key].done;
    }
  }

  void taskDone(DateTime dt, int i) {
    String key = keyFormatter.format(dt);
    if (!td.containsKey(key)) {
      return;
    }

    Task temp = td[key].tasks[i];
    td[key].tasks.removeAt(i);
    td[key].done.add(temp);
    notifyListeners();
    saveTask(dt);
  }

  void taskUndone(DateTime dt, int i) {
    String key = keyFormatter.format(dt);
    if (!td.containsKey(key)) {
      return;
    }
    Task temp = td[key].done[i];
    td[key].done.removeAt(i);
    td[key].tasks.add(temp);

    td[key].tasks.sort((a, b) => a.datetime.compareTo(b.datetime));
    notifyListeners();
    saveTask(dt);
  }

  void addTask(DateTime dt, Task t) {
    String key = keyFormatter.format(dt);

    if (!td.containsKey(key)) {
      td[key] = TodoList();
    }
    td[key].tasks.add(t);
    notifyListeners();
    saveTask(dt);
  }

  void removeTask(DateTime dt, Task t) {
    String key = keyFormatter.format(dt);

    if (!td.containsKey(key)) {
      return;
    }
    td[key].tasks.remove(t);
    notifyListeners();
    saveTask(dt);
  }

  void removeTaskIndex(DateTime dt, int i) {
    String key = keyFormatter.format(dt);
    if (!td.containsKey(key)) {
      return;
    }

    if (i > _tasks.length - 1) {
      td[dt].done.removeAt(i - _tasks.length);
    } else {
      td[dt].tasks.removeAt(i);
    }

    notifyListeners();
    saveTask(dt);
  }
}
