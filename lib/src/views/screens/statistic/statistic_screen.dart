import 'package:flutter/material.dart';

import 'package:habitool/src/custom_values/custom_colors.dart';

class StatisticScreen extends StatefulWidget {
  @override
  _StatisticScreenState createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Statistic'),
      )
    );
  }
}