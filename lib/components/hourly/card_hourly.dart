import 'package:flutter/material.dart';
import 'package:weather/components/hourly/info_hourly.dart';
import 'package:weather/utils/dependencies.dart';

class HourlyCard extends StatelessWidget {
  final int hour;
  final int weathercode;
  final double temperature;
  final double umidity;
  final int windDirection;
  final double windSpeed;
  final int precipitationrobability;
  final bool isDay;
  final double rain;
  final double percepita;
  final int visibility;
  final double pressure;
  final double? o3;
  final double? so2;
  final double? no2;
  final double? pm10;
  final double? pm25;
  final int uvIndex;

  const HourlyCard(
      {super.key,
      this.percepita = 0,
      this.visibility = 1000,
      this.umidity = 0,
      this.uvIndex = 0,
      this.o3 = 1,
      this.so2 = 0,
      this.no2 = 100,
      this.pm10 = 0,
      this.pm25 = 0,
      this.pressure = 0,
      required this.hour,
      required this.weathercode,
      required this.temperature,
      required this.windDirection,
      required this.windSpeed,
      required this.precipitationrobability,
      required this.isDay,
      required this.rain});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
            enableFeedback: false,
            onTap: () => showModalBottomSheet<void>(
                showDragHandle: true,
                context: context,
                builder: (BuildContext context) => Center(
                        child: HourlyInfo(
                      temperature: temperature,
                      windSpeed: windSpeed,
                      windDirection: windDirection,
                      probability: precipitationrobability,
                      precipitation: rain,
                      percepita: percepita,
                      visibility: visibility,
                      o3: o3,
                      so2: so2,
                      no2: no2,
                      pm10: pm10,
                      pm25: pm25,
                      UVindex: uvIndex,
                    ))),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(children: [
                Text(hour.toString()),
                const SizedBox(width: 10),
                Lottie.asset(GLOBAL.GET_ICON_FROM_WMO_CODE(weathercode, isDay),
                    width: 40, height: 40),
                const SizedBox(width: 10),
                Text('$temperature°'),
                const SizedBox(width: 20),
                if (rain == 0)
                  const Text('- assenti -')
                else
                  Column(children: [
                    Text(GLOBAL.GET_RAIN_CODE(rain)),
                    Text('$rain mm')
                  ]),
                const Spacer(),
                //Transform.rotate(
                //    angle: 180 / windDirection * pi,
                //    child: const Icon(FontAwesomeIcons.arrowRight,
                //        color: Colors.blue)),
                //Text('$windSpeed km/h'),
                //const Spacer(),
                const Icon(FontAwesomeIcons.droplet, color: Colors.blue),
                //const SizedBox(width: 10),
                Text('$precipitationrobability%'),
                //const Spacer()
              ]),
            )));
  }
}
