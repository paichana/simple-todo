import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/task.dart';

class TasksProvider with ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> _done = [];
  DateTime currentDate;

  TasksProvider() {
    currentDate = DateTime.now();
  }

  loadTask() async {
    await SharedPreferences.getInstance().then((prefs) {
      List<String> pdone = prefs.getStringList("done") ?? [];

      if (pdone.length > 0) {
        _done = pdone.map((t) {
          Map<String, dynamic> jsonDone = jsonDecode(t);
          return Task(jsonDone["info"], DateTime.parse(jsonDone["datetime"]));
        }).toList();
      } else {
        _done = [];
      }

      List<String> ptask = prefs.getStringList("tasks") ?? [];

      if (ptask.length > 0) {
        _tasks = ptask.map((t) {
          Map<String, dynamic> jsonDone = jsonDecode(t);
          return Task(jsonDone["info"], DateTime.parse(jsonDone["datetime"]));
        }).toList();
      } else {
        _tasks = [];
      }
    });
    notifyListeners();
  }

  saveTask() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        "done", _done.map((t) => t.itemToJsonString()).toList());
    prefs.setStringList(
        "tasks", _tasks.map((t) => t.itemToJsonString()).toList());
  }

  List<Task> get tasks {
    return [..._tasks];
  }

  List<Task> get done {
    return [..._done];
  }

  void taskDone(int i) {
    Task temp = _tasks[i];
    _tasks.removeAt(i);
    _done.add(temp);
    notifyListeners();
    saveTask();
  }

  void taskUndone(int i) {
    Task temp = _done[i];
    _done.removeAt(i);
    _tasks.add(temp);
    _tasks.sort((a, b) => a.datetime.compareTo(b.datetime));
    notifyListeners();
    saveTask();
  }

  void addTask(Task t) {
    _tasks.add(t);
    notifyListeners();
    saveTask();
  }

  void removeTask(Task t) {
    _tasks.remove(t);
    notifyListeners();
    saveTask();
  }

  void removeTaskIndex(int i) {
    if (i > _tasks.length - 1) {
      _done.removeAt(i - _tasks.length);
    } else {
      _tasks.removeAt(i);
    }

    notifyListeners();
    saveTask();
  }
}
