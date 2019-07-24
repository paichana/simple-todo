import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'models/task.dart';

class AppState extends InheritedWidget {
  AppState({this.done, this.task, child}) : super(child: child);

  final List<Task> task;
  final List<Task> done;

  @override
  bool updateShouldNotify(AppState oldWidget) {
    // return (!listEquals(oldWidget.done, done) ||
    //     !listEquals(oldWidget.task, task));
    return true;
  }

  static AppState of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppState);
  }
}
