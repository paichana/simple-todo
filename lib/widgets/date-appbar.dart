import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class DateAppBar extends StatefulWidget {
  final BuildContext context;
  DateTime selectedDate;

  DateAppBar({
    Key key,
    @required this.context,
  }) : super(key: key) {
    selectedDate = DateTime.now();
  }

  @override
  _DateAppBarState createState() => _DateAppBarState();
}

class _DateAppBarState extends State<DateAppBar> {
  var dateFormatter = DateFormat('dd EEEE');
  final timeFormat = DateFormat("HH:mm");

  String dateString;

  @override
  void initState() {
    super.initState();
    dateString = dateFormatter.format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
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
                      onPressed: () {
                        _showDialog();
                      },
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

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            child: Wrap(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: "Shop grosseries"),
                ),
                DateTimeField(
                  format: timeFormat,
                  onShowPicker: (context, currentValue) async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.convert(time);
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("ADD"),
              onPressed: () {},
            ),
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  List<Widget> dateTitle(BuildContext context) {
    return <Widget>[
      Text(
        dateString,
        style: TextStyle(
          fontWeight: FontWeight.w100,
          fontSize: 30,
          color: Theme.of(context).primaryColorLight,
        ),
      ),
      Text(
        '8 OPEN TASKS',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).primaryColorLight,
        ),
      ),
    ];
  }
}
