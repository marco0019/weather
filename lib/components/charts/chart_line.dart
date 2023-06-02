import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/utils/dependencies.dart';

class ChartLineExample extends StatelessWidget {
  final List<Map<String, dynamic>> lines;
  final List<Gradient> linesGradient;
  final String horizontalAxisName;
  final List<String> verticalAxisNames;
  final DateTime? date;

  const ChartLineExample(
      {super.key,
      this.date = null,
      required this.lines,
      required this.linesGradient,
      required this.horizontalAxisName,
      required this.verticalAxisNames});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
          gridData: FlGridData(show: false, verticalInterval: 1),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
              topTitles: AxisTitles(),
              bottomTitles: AxisTitles(),
              rightTitles: AxisTitles()),
          lineTouchData: LineTouchData(enabled: true),
          lineBarsData: [
            for (int i = 0; i < lines.length; i++)
              LineChartBarData(
                  spots: [
                    for (int j = 0;
                        j <
                            (lines[i][horizontalAxisName] as List<dynamic>)
                                .length;
                        j++)
                      if (date == null ||
                          GLOBAL.HAS_SAME_DAY(date!,
                              DateTime.parse(lines[i][horizontalAxisName][j])))
                        FlSpot(
                            DateTime.parse(lines[i][horizontalAxisName][j])
                                .millisecondsSinceEpoch
                                .toDouble(),
                            (lines[i][verticalAxisNames[i]][j] ?? 0).toDouble())
                  ],
                  dotData: FlDotData(show: false),
                  isCurved: true,
                  barWidth: 2,
                  //belowBarData: BarAreaData(show: true),
                  gradient: linesGradient[i])
          ]),
      swapAnimationDuration: const Duration(milliseconds: 1000),
      swapAnimationCurve: Curves.elasticInOut,
    );
  }
}
