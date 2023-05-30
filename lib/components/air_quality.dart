import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:weather/components/charts/chart_line.dart';
import 'package:weather/providers/init.dart';
import 'package:weather/utils/dependencies.dart';

class AirQuality extends StatelessWidget {
  final double latitude;
  final double longitude;

  const AirQuality(
      {super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherProvider>();
    return Card(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
      child: FutureBuilder(
        future: weather.fetchAirQuality(lat: latitude, lon: longitude),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ListView(scrollDirection: Axis.horizontal,
            children: [
              ChartLineExample(lines: lines, linesGradient: linesGradient, horizontalAxisName: horizontalAxisName, verticalAxisNames: verticalAxisNames)
            ])
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    ));
  }
}
/*return Row(children: [
              CircularPercentIndicator(
                animation: true,
                animationDuration: 1000,
                curve: Curves.bounceInOut,
                progressColor: GLOBAL.GET_IQA_INFO(snapshot.data!['hourly']
                    ['european_aqi'][0] as int)['color'],
                backgroundColor: (GLOBAL.GET_IQA_INFO(snapshot.data!['hourly']
                        ['european_aqi'][0] as int)['color'] as Color)
                    .withAlpha(80),
                radius: 100,
                percent: (300 -
                        (snapshot.data!['hourly']['european_aqi'][0] as int)) /
                    300,
                lineWidth: 25,
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                  snapshot.data!['hourly']['european_aqi'][0].toString(),
                  style: const TextStyle(fontSize: 50),
                ),
              ),
              const Spacer(),
              const Column(children: [
                Text('prova1'),
                Text('prova1'),
                Text('prova1'),
              ])
            ]);*/