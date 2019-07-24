import 'package:flutter/material.dart';

import 'colors/colors.dart';
import 'pages/main-page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODUO',
      theme: ThemeData(
        primarySwatch: primary,
        primaryColorLight: Color.fromRGBO(237, 237, 237, 1),
        primaryColorDark: Color.fromRGBO(30, 30, 30, 1),
        accentColor: Color.fromRGBO(232, 58, 96, 1),
        unselectedWidgetColor: Color.fromRGBO(89, 89, 89, 1),
      ),
      home: MainPage(),
    );
  }
}
