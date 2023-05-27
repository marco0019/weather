import 'package:flutter/cupertino.dart';
import 'package:weather/components/card_data.dart';
import 'package:weather/providers/weather_provider.dart';
import 'package:weather/utils/dependecies.dart';

class CurrentDay extends StatelessWidget {
  final Map<String, dynamic> info;

  const CurrentDay({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    final int index = GLOBAL.GET_INDEX_NOW_FROM_DATE(info);
    return Column(children: [
      const SizedBox(height: 10),
      Row(children: [
        Lottie.asset(
            GLOBAL.GET_ICON_FROM_WMO_CODE(
                info['weathercode'][index], info['is_day'][index] == 1),
            width: 150,
            height: 150),
        const Spacer(),
        Text('${info['temperature_2m'][index]}°',
            style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold))
      ]),
      const SizedBox(height: 20),
      Row(children: [
        const Spacer(),
        CardData(
            iconName: 'assets/icons/wind.json',
            data: Text('${info['windspeed_10m'][index]}km/h')),
        const Spacer(),
        CardData(
            iconName: 'assets/icons/wind.json',
            data: Text('${info['visibility'][index]}m')),
        const Spacer(),
        CardData(
            iconName: 'assets/icons/wind.json',
            data: Text('${info['precipitation_probability'][index]}%')),
        const Spacer(),
      ])
    ]);
  }
}
