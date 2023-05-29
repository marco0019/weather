import 'package:flutter/material.dart';
import 'package:weather/components/init.dart';

final class HourlyList extends StatelessWidget {
  final Map<String, dynamic> value;
  final DateTime day;
  final int range;

  const HourlyList(
      {super.key, this.range = 1, required this.day, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            for (int i = 0; i < (value['time'] as List<dynamic>).length; i++)
              if (DateTime.parse(value['time'][i]).hour % range == 0 &&
                  DateTime.parse(value['time'][i]).year == day.year &&
                  DateTime.parse(value['time'][i]).month == day.month &&
                  DateTime.parse(value['time'][i]).day == day.day)
                HourlyCard(
                    hour: DateTime.parse(value['time'][i]).hour,
                    weathercode: value['weathercode'][i] as int,
                    temperature: value['temperature_2m'][i] as double,
                    windDirection: value['winddirection_10m'][i] as int,
                    windSpeed: value['windspeed_10m'][i] as double,
                    precipitationrobability:
                        value['precipitation_probability'][i] as int,
                    isDay: (value['is_day'][i] as int) == 1,
                    rain: value['precipitation'][i] as double)
          ],
        ));
  }
}
//pk.99377b1a33c03093ee4e776812215a80
