import 'package:flutter/material.dart';
import 'package:weather/components/hourly/info_hourly.dart';
import 'package:weather/utils/dependencies.dart';

class HourlyCard extends StatelessWidget {
  final int hour;
  final int weathercode;
  final double temperature;
  final int windDirection;
  final double windSpeed;
  final int precipitationrobability;
  final bool isDay;
  final double rain;

  const HourlyCard(
      {super.key,
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
        elevation: .5,
        child: InkWell(
            enableFeedback: false,
            onTap: () => showModalBottomSheet<void>(
                showDragHandle: true,
                context: context,
                builder: (BuildContext context) => const Text('placeholder')),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(children: [
                Text(hour.toString()),
                const SizedBox(width: 10),
                Lottie.asset(GLOBAL.GET_ICON_FROM_WMO_CODE(weathercode, isDay),
                    width: 40, height: 40),
                const SizedBox(width: 10),
                Text('$temperature°'),
                const VerticalDivider(
                  color: Colors.black,
                  thickness: 10,
                  width: 10,
                ),
                const Spacer(),
                Transform.rotate(
                    angle: 360 / windDirection,
                    child: const Icon(FontAwesomeIcons.arrowDown,
                        color: Colors.blue)),
                Text('$windSpeed km/h'),
                const Spacer(),
                const Icon(
                  FontAwesomeIcons.cloudRain,
                  color: Colors.blue,
                ),
                const SizedBox(width: 7),
                Text('$rain mm'),
                const Spacer(),
                const Icon(FontAwesomeIcons.droplet, color: Colors.blue),
                //const SizedBox(width: 10),
                Text('$precipitationrobability%'),
                const Spacer()
              ]),
            )));
  }
}
