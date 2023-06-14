import 'package:flutter/material.dart';
import 'package:weather/components/dot.dart';
import 'package:weather/utils/dependencies.dart';
import 'dart:math';

class HourlyInfo extends StatefulWidget {
  final int? visibility;
  final double precipitation;
  final int probability;
  final int? humidity;
  final int? uvIndex;
  final double temperature;
  final double percepita;
  final double windSpeed;
  final int windDirection;
  final double pressure;
  final double? o3;
  final double? no2;
  final double? so2;
  final double? pm10;
  final double? pm25;
  final int? aqi;

  HourlyInfo(
      {super.key,
      this.visibility = 0,
      this.uvIndex = 0,
      this.pressure = 0,
      this.o3 = 0,
      this.no2 = 0,
      this.so2 = 0,
      this.pm10 = 0,
      this.pm25 = 0,
      this.aqi = 0,
      this.humidity = 0,
      required this.precipitation,
      required this.probability,
      required this.temperature,
      required this.percepita,
      required this.windSpeed,
      required this.windDirection});
  @override
  State<HourlyInfo> createState() => _HourlyInfoState();
}

class _HourlyInfoState extends State<HourlyInfo> {
  late List<int> state;
  _HourlyInfoState() {
    setState(() => state = GLOBAL.GET_QUALITY_OF_AIR([
          (widget.pm25 ?? 10).toInt(),
          (widget.pm10 ?? 10).toInt(),
          (widget.no2 ?? 10).toInt(),
          (widget.o3 ?? 10).toInt(),
          (widget.so2 ?? 10).toInt()
        ]));
  }
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      if (widget.visibility != null)
        Text('Visibility - ${widget.visibility! / 1000} km',
            textAlign: TextAlign.center),
      if (widget.visibility != null) const SizedBox(height: 10),
      Text('Precipitation - ${widget.precipitation} mm',
          textAlign: TextAlign.center),
      const SizedBox(height: 10),
      Text('Probability - ${widget.probability}%', textAlign: TextAlign.center),
      const SizedBox(height: 10),
      if (widget.humidity != null)
        Text('Umidity - ${widget.humidity} %', textAlign: TextAlign.center),
      if (widget.humidity != null) const SizedBox(height: 10),
      if (widget.uvIndex != null)
        Text('UV index - ${widget.uvIndex}', textAlign: TextAlign.center),
      if (widget.uvIndex != null) const SizedBox(height: 10),
      Text('Temperature - ${widget.temperature} °C',
          textAlign: TextAlign.center),
      const SizedBox(height: 10),
      Text('Percepita - ${widget.percepita} °C', textAlign: TextAlign.center),
      const SizedBox(height: 10),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
            'Wind - ${GLOBAL.GET_WIND_DIRECTION(widget.windDirection)} ${widget.windSpeed} km/h ',
            textAlign: TextAlign.center),
        Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: Transform.rotate(
                angle: 180 / widget.windDirection * pi,
                child: const Icon(FontAwesomeIcons.arrowRight, size: 10))),
      ]),
      const SizedBox(height: 10),
      Text('Pressure - ${widget.pressure} mb', textAlign: TextAlign.center),
      const SizedBox(height: 10),
      Card(
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(GLOBAL.AIR_STATES[state[5]],
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(children: [
                    Dot(size: 10, color: GLOBAL.AIR_QUALITY_COLORS[state[3]]),
                    const SizedBox(width: 10),
                    Text('O3 ${widget.o3} μg/m³')
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    Dot(size: 10, color: GLOBAL.AIR_QUALITY_COLORS[state[2]]),
                    const SizedBox(width: 10),
                    Text('NO2 ${widget.no2} μg/m³')
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    Dot(size: 10, color: GLOBAL.AIR_QUALITY_COLORS[state[4]]),
                    const SizedBox(width: 10),
                    Text('SO2 ${widget.so2} μg/m³')
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    Dot(size: 10, color: GLOBAL.AIR_QUALITY_COLORS[state[1]]),
                    const SizedBox(width: 10),
                    Text('PM10 ${widget.pm10} μg/m³')
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    Dot(size: 10, color: GLOBAL.AIR_QUALITY_COLORS[state[0]]),
                    const SizedBox(width: 10),
                    Text('PM2.5 ${widget.pm25} μg/m³')
                  ])
                ]),
                const Spacer(),
                CircularPercentIndicator(
                    animation: true,
                    animationDuration: 1000,
                    curve: Curves.bounceInOut,
                    progressColor: GLOBAL.GET_COLOR_OF_AQI(widget.aqi ?? 0),
                    backgroundColor:
                        GLOBAL.GET_COLOR_OF_AQI(widget.aqi ?? 0).withAlpha(75),
                    radius: 90,
                    percent: (widget.aqi ?? 0) / 100,
                    lineWidth: 25,
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Text((widget.aqi ?? '0').toString(),
                        style: const TextStyle(fontSize: 50)))
              ])))
    ]);
  }
}
