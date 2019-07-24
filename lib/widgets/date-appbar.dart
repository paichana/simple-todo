import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class DateAppBar extends StatelessWidget {
  const DateAppBar({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

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
        "formattedDate",
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
