import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/components/hourly/info_hourly.dart';

class Esempi extends StatelessWidget {
  const Esempi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('esempi'),
      ),
      body: Center(
        child: HourlyInfo(
          visibility: 1000,
          precipitation: 0.2,
          probability: 67,
          umidity: 23,
          UVindex: 0,
          temperature: 19.9,
          percepita: 20.9,
          windDirection: 290,
          windSpeed: 10,
          pressure: 10212,
          o3: 12,
          no2: 1,
          so2: 4,
          pm10: 10,
          pm25: 12,
          aqi: 280,
        ),
      ),
    );
  }
}
