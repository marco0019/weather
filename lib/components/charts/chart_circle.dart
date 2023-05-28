import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleChartExample extends StatelessWidget {
  const CircleChartExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PieChart(
        PieChartData(sectionsSpace: 0, centerSpaceRadius: 100, sections: [
      PieChartSectionData(
        value: 25,
        color: Colors.blue,
        title: '25%',
        radius: 80,
        titleStyle: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        value: 35,
        color: Colors.green,
        title: '35%',
        radius: 80,
        titleStyle: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        value: 40,
        color: Colors.orange,
        title: '40%',
        radius: 80,
        titleStyle: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      )
    ]));
  }
}
