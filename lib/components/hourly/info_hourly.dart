import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:weather/components/dot.dart';
import 'package:weather/utils/dependencies.dart';
import 'dart:math';

class HourlyInfo extends StatelessWidget {
  int? visibility;
  double precipitation;
  int probability;
  int? umidity;
  int? UVindex;
  double temperature;
  double percepita;
  double windSpeed;
  int windDirection;
  int? pressure;
  double? o3;
  double? no2;
  double? so2;
  double? pm10;
  double? pm25;
  int? aqi;
  List<int> state = [];
  HourlyInfo(
      {super.key,
      this.visibility = 0,
      this.UVindex = 0,
      this.pressure = 0,
      this.o3 = 0,
      this.no2 = 0,
      this.so2 = 0,
      this.pm10 = 0,
      this.pm25 = 0,
      required this.precipitation,
      required this.probability,
      required this.temperature,
      required this.percepita,
      required this.windSpeed,
      required this.windDirection}) {
    state = GLOBAL.GET_QUALITY_OF_AIR([
      (pm25 ?? 10).toInt(),
      (pm10 ?? 10).toInt(),
      (no2 ?? 10).toInt(),
      (o3 ?? 10).toInt(),
      (so2 ?? 10).toInt()
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      if (visibility != null)
        Text('Visibility - ${visibility! / 1000} km',
            textAlign: TextAlign.center),
      if (visibility != null) const SizedBox(height: 10),
      Text('Precipitation - $precipitation mm', textAlign: TextAlign.center),
      const SizedBox(height: 10),
      Text('Probability - $probability%', textAlign: TextAlign.center),
      const SizedBox(height: 10),
      if (umidity != null)
        Text('Umidity - $umidity %', textAlign: TextAlign.center),
      if (umidity != null) const SizedBox(height: 10),
      if (UVindex != null)
        Text('UV index - $UVindex', textAlign: TextAlign.center),
      if (UVindex != null) const SizedBox(height: 10),
      Text('Temperature - $temperature °C', textAlign: TextAlign.center),
      const SizedBox(height: 10),
      Text('Percepita - $percepita °C', textAlign: TextAlign.center),
      const SizedBox(height: 10),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
            'Wind - ${GLOBAL.GET_WIND_DIRECTION(windDirection)} $windSpeed km/h ',
            textAlign: TextAlign.center),
        Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: Transform.rotate(
                angle: 180 / windDirection * pi,
                child: const Icon(FontAwesomeIcons.arrowRight, size: 10))),
      ]),
      const SizedBox(height: 10),
      if (pressure != null)
        Text('Pressure - $pressure mb', textAlign: TextAlign.center),
      if (pressure != null) const SizedBox(height: 10),
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
                    progressColor: GLOBAL.GET_IQA_INFO(aqi ?? 0)['color'],
                    backgroundColor:
                        (GLOBAL.GET_IQA_INFO(aqi ?? 0)['color'] as Color)
                            .withAlpha(75),
                    radius: 90,
                    percent: (300 - (aqi ?? 0)) / 300,
                    lineWidth: 25,
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Text(aqi.toString(),
                        style: const TextStyle(fontSize: 50)))
              ])))
    ]);
  }
}
