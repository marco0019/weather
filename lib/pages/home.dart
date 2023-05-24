import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather/components/card-daily.dart';
import 'package:weather/components/card-data.dart';
import 'package:weather/components/card-hourly.dart';
import 'package:weather/components/card-weather-horizontal.dart';
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
        body: FutureBuilder(
            future: weather,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var value = Map<String, dynamic>.from(snapshot.data as Map);
                final limit = value['daily']['time'].length;
                const hours = 24;
                return ListView(
                  children: [
                    const Text('Manziana', style: TextStyle(fontSize: 50)),
                    Text(
                      '${GLOBAL.MOUNTHS[DateTime.now().month]} ${DateTime.now().day}, ${DateTime.now().year}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Row(children: [
                      Lottie.asset(GLOBAL.WEATHER_ICONS[0],
                          width: 150, height: 150),
                      const Spacer(),
                      const Text(
                        '28°',
                        style: TextStyle(
                            fontSize: 80, fontWeight: FontWeight.bold),
                      )
                    ]),
                    const SizedBox(height: 20),
                    const Row(children: [
                      Spacer(),
                      CardData(iconName: FontAwesomeIcons.wind, data: '12%'),
                      Spacer(),
                      CardData(iconName: FontAwesomeIcons.cloud, data: '12%'),
                      Spacer(),
                      CardData(iconName: FontAwesomeIcons.droplet, data: '12%'),
                      Spacer(),
                    ]),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 10),
                    const Text(
                      'Today',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    ),
                    Container(
                        color: Colors.white12,
                        height: 175,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              CardWeatherHorizontal(
                                  date: 'Mon 21',
                                  value: '12*',
                                  iconName:
                                      GLOBAL.GET_ICON_FROM_WMO_CODE(50, false)),
                              CardWeatherHorizontal(
                                  date: 'Mon 21',
                                  value: '12*',
                                  iconName:
                                      GLOBAL.GET_ICON_FROM_WMO_CODE(50, false)),
                              CardWeatherHorizontal(
                                  date: 'Mon 21',
                                  value: '12*',
                                  iconName:
                                      GLOBAL.GET_ICON_FROM_WMO_CODE(50, false)),
                              CardWeatherHorizontal(
                                  date: 'Mon 21',
                                  value: '12*',
                                  iconName:
                                      GLOBAL.GET_ICON_FROM_WMO_CODE(50, false)),
                              CardWeatherHorizontal(
                                  date: 'Mon 21',
                                  value: '12*',
                                  iconName:
                                      GLOBAL.GET_ICON_FROM_WMO_CODE(50, false)),
                              CardWeatherHorizontal(
                                  date: 'Mon 21',
                                  value: '12*',
                                  iconName:
                                      GLOBAL.GET_ICON_FROM_WMO_CODE(50, false)),
                              CardWeatherHorizontal(
                                  date: 'Mon 21',
                                  value: '12*',
                                  iconName:
                                      GLOBAL.GET_ICON_FROM_WMO_CODE(50, false)),
                              CardWeatherHorizontal(
                                  date: 'Mon 21',
                                  value: '12*',
                                  iconName:
                                      GLOBAL.GET_ICON_FROM_WMO_CODE(50, false)),
                            ])),
                    const SizedBox(height: 50),
                    Card(
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
                                  //Spacer()
                                ],
                              ),
                              for (var i = 0; i < limit; i++)
                                WeatherCard(
                                    pageRedirect: HourlyPage(
                                        data: value['daily'],
                                        day:
                                            '${GLOBAL.DAYS[DateFormat('yyyy-MM-dd').parseUtc(value['daily']['time'][i]).weekday - 1]} ${DateFormat('yyyy-MM-dd').parseUtc(value['daily']['time'][i]).day}, ${DateFormat('yyyy-MM-dd').parseUtc(value['daily']['time'][i]).month}'),
                                    weatherCode: value['daily']['weathercode']
                                        [i],
                                    precipitationProbability: value['daily']
                                        ['precipitation_probability_max'][i],
                                    weatherIconUrl:
                                        GLOBAL.GET_ICON_FROM_WMO_CODE(
                                            value['daily']['weathercode'][i],
                                            GLOBAL.INCLUDE(
                                                6, 20, DateTime.now().hour)),
                                    min:
                                        '${value['daily']['temperature_2m_min'][i]}°',
                                    max:
                                        '${value['daily']['temperature_2m_max'][i]}°',
                                    day:
                                        '${GLOBAL.DAYS[DateFormat('yyyy-MM-dd').parseUtc(value['daily']['time'][i]).weekday - 1]} ${DateFormat('yyyy-MM-dd').parseUtc(value['daily']['time'][i]).day}, ${DateFormat('yyyy-MM-dd').parseUtc(value['daily']['time'][i]).month}',
                                    //value['daily']['time'][i].toString()
                                    wind: value['daily']
                                            ['winddirection_10m_dominant'][i]
                                        .toString())
                            ],
                          )),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const LinearProgressIndicator();
            }));
  }
}
