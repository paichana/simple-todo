class Task {
  Task(this.info, this.datetime);
  bool isDone = false;
  String info;
  DateTime datetime;

  void toggleDone() {
    isDone = !isDone;
  }
}
