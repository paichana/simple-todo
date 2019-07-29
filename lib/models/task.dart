import 'dart:convert';

class Task {
  Task(this.info, this.datetime);
  bool isDone = false;
  String info;
  DateTime datetime;

  void toggleDone() {
    isDone = !isDone;
  }

  toJson() {
    return {
      "is_done": isDone,
      "info": info,
      "datetime": datetime.toIso8601String(),
    };
  }

  String itemToJsonString() {
    String json = jsonEncode(this);
    print('JSOMN  = $json');
    return json;
  }
}

class TodoList {
  List<Task> done = [];
  List<Task> tasks = [];
}
