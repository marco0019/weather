import 'package:flutter/material.dart';
import 'package:weather/components/init.dart';
import 'package:weather/pages/init.dart';
import '../utils/dependencies.dart';

final class DailyList extends StatelessWidget {
  final int limit;
  final Map<String, dynamic> value;

  const DailyList({super.key, required this.limit, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Row(
                children: [
                  Text('Next Days',
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.start),
                ],
              ),
              for (var i = 0; i < limit; i++)
                WeatherCard(
                    pageRedirect: HourlyPage(
                        data: value['daily'],
                        day:
                            '${GLOBAL.DAYS[DateFormat('yyyy-MM-dd').parseUtc(value['daily']['time'][i]).weekday - 1]} ${DateFormat('yyyy-MM-dd').parseUtc(value['daily']['time'][i]).day}, ${DateFormat('yyyy-MM-dd').parseUtc(value['daily']['time'][i]).month}'),
                    weatherCode: value['daily']['weathercode'][i],
                    precipitationProbability: value['daily']
                        ['precipitation_probability_max'][i],
                    weatherIconUrl: GLOBAL.GET_ICON_FROM_WMO_CODE(
                        value['daily']['weathercode'][i],
                        GLOBAL.INCLUDE(6, 20, DateTime.now().hour)),
                    min: '${value['daily']['temperature_2m_min'][i]}°',
                    max: '${value['daily']['temperature_2m_max'][i]}°',
                    day:
                        '${GLOBAL.DAYS[DateFormat('yyyy-MM-dd').parseUtc(value['daily']['time'][i]).weekday - 1].substring(0, 3)} ${DateFormat('yyyy-MM-dd').parseUtc(value['daily']['time'][i]).day}, ${DateFormat('yyyy-MM-dd').parseUtc(value['daily']['time'][i]).month}',
                    wind: value['daily']['winddirection_10m_dominant'][i]
                        .toString()),
              const SizedBox(height: 20)
            ],
          )),
    );
  }
}
