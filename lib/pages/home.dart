import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/components/card-daily.dart';
import 'package:weather/components/card-hourly.dart';
import 'package:weather/components/card-info.dart';
import 'package:weather/providers/http-requests.dart';
import 'package:weather/utils/globals.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final weather = context.watch<HttpRequest>().weather;
    return Scaffold(
        appBar: AppBar(
          title: const Text('prova'),
        ),
        body: FutureBuilder(
            future: weather,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var value = Map<String, dynamic>.from(snapshot.data as Map);
                final limit = value['daily']['time'].length;
                return ListView(
                  children: [
                    Row(children: [
                      const Spacer(),
                      CardInfo(
                          title: 'MIN',
                          currentTemp:
                              value['hourly']['temperature_2m'][0].toString(),
                          weatherCode: 0),
                      const Spacer(),
                      CardInfo(
                          title: 'MAX',
                          currentTemp:
                              value['hourly']['temperature_2m'][0].toString(),
                          weatherCode: 0),
                      const Spacer(),
                    ]),
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
                              '${GLOBAL.DAYS[DateFormat('yyyy-MM-dd').parseUtc(value['daily']['time'][i]).weekday - 1]} ${DateFormat('yyyy-MM-dd').parseUtc(value['daily']['time'][i]).day}, ${DateFormat('yyyy-MM-dd').parseUtc(value['daily']['time'][i]).month}', //value['daily']['time'][i].toString()
                          wind: value['daily']['winddirection_10m_dominant'][i]
                              .toString())
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const LinearProgressIndicator();
            }));
  }
}

                    /*Row(
                      children: [
                        for (var i = 0; i < 3; i++)
                          Column(children: [
                            for (int j = 0; j < 5; j++)
                              Lottie.asset(GLOBAL.WEATHER_ICONS[i * 5 + j],
                                  width: 80, height: 80)
                          ]),
                      ],
                    ),*/