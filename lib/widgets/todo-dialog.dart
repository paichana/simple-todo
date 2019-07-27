import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:simple_todo/models/task.dart';

import '../providers/tasks.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({
    Key key,
    @required this.timeFormat,
    @required this.taskData,
  }) : super(key: key);

  final DateFormat timeFormat;
  final TasksProvider taskData;

  @override
  _AddTodoDialogState createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  @override
  Widget build(BuildContext context) {
    final infoController = TextEditingController();
    final dateTimeController = TextEditingController();

    var selectedDate = DateTime.now();
    return AlertDialog(
      content: Container(
        child: Wrap(
          children: <Widget>[
            TextField(
              controller: infoController,
              decoration: InputDecoration(hintText: "Shop grosseries"),
            ),
            DateTimeField(
              format: widget.timeFormat,
              controller: dateTimeController,
              onShowPicker: (context, currentValue) async {
                final time = await showTimePicker(
                  context: context,
                  initialTime:
                      TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                );

                return DateTimeField.convert(time);
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
            widget.taskData.addTask(Task(
                infoController.text, DateTime.parse(dateTimeController.text)));
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
