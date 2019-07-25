import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double progress;

  ProgressBar(this.progress);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      child: LinearProgressIndicator(
        value: progress,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
