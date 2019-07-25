import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo/models/task.dart';

import '../providers/tasks.dart';

class AddTodoDialog extends StatelessWidget {
  const AddTodoDialog({
    Key key,
    @required this.timeFormat,
    @required this.taskData,
  }) : super(key: key);

  final DateFormat timeFormat;
  final TasksProvider taskData;

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();

    var selectedDate = DateTime.now();
    return AlertDialog(
      content: Container(
        child: Wrap(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: "Shop grosseries"),
            ),
            DateTimeField(
              format: timeFormat,
              onShowPicker: (context, currentValue) async {
                final time = await showTimePicker(
                  context: context,
                  initialTime:
                      TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                );
                return DateTimeField.convert(time);
              },
              onSaved: (dt) {
                if (dt != null) {
                  selectedDate =
                      DateTime(dt.year, dt.month, dt.day, dt.hour, dt.minute);
                }
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("ADD"),
          onPressed: () {
            taskData.addTask(Task(nameController.text, selectedDate));
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
