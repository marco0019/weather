import 'package:flutter/material.dart';
import 'package:weather/components/charts/chart_line.dart';

class AirQuality extends StatelessWidget {
  final Map<String, dynamic> data;
  const AirQuality(
      {super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
            child: SizedBox(
                height: 300,
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ChartLineExample(
                        linesGradient: const [
                          LinearGradient(
                              colors: [Colors.green, Colors.greenAccent])
                        ],
                        lines: [data['hourly']],
                        horizontalAxisName: 'time',
                        verticalAxisNames: const [
                          'european_aqi',
                        ])))));
  }
}