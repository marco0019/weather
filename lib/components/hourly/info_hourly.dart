import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:weather/components/dot.dart';
import 'package:weather/utils/dependencies.dart';

class HourlyInfo extends StatelessWidget {
  final int visibility;
  final double precipitation;
  final int probability;
  final int umidity;
  final int UVindex;
  final double temperature;
  final double percepita;
  final double windSpeed;
  final int windDirection;
  final int pressure;
  final double o3;
  final double no2;
  final double so2;
  final double pm10;
  final double pm25;
  final int aqi;
  List<int> state = [];

  HourlyInfo(
      {super.key,
      required this.visibility,
      required this.precipitation,
      required this.probability,
      required this.umidity,
      required this.UVindex,
      required this.temperature,
      required this.percepita,
      required this.windSpeed,
      required this.windDirection,
      required this.pressure,
      required this.o3,
      required this.no2,
      required this.so2,
      required this.pm10,
      required this.pm25,
      required this.aqi}) {
    state = GLOBAL.GET_QUALITY_OF_AIR(
        [pm25.toInt(), pm10.toInt(), no2.toInt(), o3.toInt(), so2.toInt()]);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Text('Visibility - ${visibility / 1000} km', textAlign: TextAlign.center),
      const SizedBox(height: 10),
      Text('Precipitation - $precipitation mm', textAlign: TextAlign.center),
      const SizedBox(height: 10),
      Text('Probability - $probability%', textAlign: TextAlign.center),
      const SizedBox(height: 10),
      Text('Umidity - $umidity %', textAlign: TextAlign.center),
      const SizedBox(height: 10),
      Text('UV index - $UVindex', textAlign: TextAlign.center),
      const SizedBox(height: 10),
      Text('Temperature - $temperature °C', textAlign: TextAlign.center),
      const SizedBox(height: 10),
      Text('Percepita - $percepita °C', textAlign: TextAlign.center),
      const SizedBox(height: 10),
      Text('Wind - ${GLOBAL.GET_WIND_DIRECTION(windDirection)} $windSpeed km/h',
          textAlign: TextAlign.center),
      const SizedBox(height: 10),
      Text('Pressure - $pressure mb', textAlign: TextAlign.center),
      const SizedBox(height: 10),
      Card(
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(children: [
                Column(children: [
                  Text(
                    GLOBAL.AIR_STATES[state[5]],
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(children: [
                    Dot(size: 10, color: GLOBAL.AIR_QUALITY_COLORS[state[3]]),
                    const SizedBox(width: 10),
                    Text('O3 $o3 μg/m³')
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    Dot(size: 10, color: GLOBAL.AIR_QUALITY_COLORS[state[2]]),
                    const SizedBox(width: 10),
                    Text('NO2 $no2 μg/m³')
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    Dot(size: 10, color: GLOBAL.AIR_QUALITY_COLORS[state[4]]),
                    const SizedBox(width: 10),
                    Text('SO2 $so2 μg/m³')
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    Dot(size: 10, color: GLOBAL.AIR_QUALITY_COLORS[state[1]]),
                    const SizedBox(width: 10),
                    Text('PM10 $pm10 μg/m³')
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    Dot(size: 10, color: GLOBAL.AIR_QUALITY_COLORS[state[0]]),
                    const SizedBox(width: 10),
                    Text('PM2.5 $pm25 μg/m³')
                  ])
                ]),
                const Spacer(),
                CircularPercentIndicator(
                  animation: true,
                  animationDuration: 1000,
                  curve: Curves.bounceInOut,
                  progressColor: GLOBAL.GET_IQA_INFO(aqi)['color'],
                  backgroundColor: (GLOBAL.GET_IQA_INFO(aqi)['color'] as Color)
                      .withAlpha(75),
                  radius: 90,
                  percent: (300 - aqi) / 300,
                  lineWidth: 25,
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Text(
                    aqi.toString(),
                    style: const TextStyle(fontSize: 50),
                  ),
                ),
                //SegmentedButton(segments: ButtonSegment(value:), selected: selected)
              ])))
    ]);
  }
}
