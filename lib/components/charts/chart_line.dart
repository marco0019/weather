import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/utils/dependencies.dart';

class ChartLineExample extends StatelessWidget {
  final List<Map<String, dynamic>> lines;
  final List<Gradient> linesGradient;
  final String horizontalAxisName;
  final List<String> verticalAxisNames;

  const ChartLineExample(
      {super.key,
      required this.lines,
      required this.linesGradient,
      required this.horizontalAxisName,
      required this.verticalAxisNames});

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
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
                    FlSpot(
                        DateTime.parse(lines[i][horizontalAxisName][j])
                            .millisecondsSinceEpoch
                            .toDouble(),
                        lines[i][verticalAxisNames[i]][j] as double)
                ],
                dotData: FlDotData(show: true),
                isCurved: true,
                barWidth: 2,
                //belowBarData: BarAreaData(
                //    show: true, color: const Color.fromRGBO(50, 100, 200, .2)),
                gradient: linesGradient[i])
        ]));
  }
}
