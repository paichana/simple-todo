import 'package:flutter/widgets.dart';
import '../models/task.dart';

class TasksProvider with ChangeNotifier {
  List<Task> _tasks = [
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
  List<Task> _done = [];

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
  }

  void taskUndone(int i) {
    Task temp = _done[i];
    _done.removeAt(i);
    _tasks.add(temp);
    _tasks.sort((a, b) => a.datetime.compareTo(b.datetime));
    notifyListeners();
  }
}
