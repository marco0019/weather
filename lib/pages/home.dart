import 'package:flutter/material.dart';
import 'package:weather/components/init.dart';
import 'package:weather/providers/init.dart';
import '../utils/dependecies.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final weather = context.watch<HttpRequest>().weather;
    final isDarkMode = context.watch<ThemeModel>().isDarkMode;
    final dailyIndex = context.watch<DailyIndex>();
    return Scaffold(
      drawer: Text('drawer'),
        body: FutureBuilder(
            future: weather,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var value = Map<String, dynamic>.from(snapshot.data as Map);
                final limit = value['daily']['time'].length;
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      centerTitle: false,
                      pinned: true,
                      expandedHeight: 200,
                      leading: const ChangeTheme(),
                      flexibleSpace: FlexibleSpaceBar(
                        expandedTitleScale: 2,
                        //background: Container(color: Colors.pink),
                        title: Text(
                          'Manziana',
                          style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: Text(
                      '${GLOBAL.MOUNTHS[DateTime.now().month]} ${DateTime.now().day}, ${DateTime.now().year}',
                      style: const TextStyle(fontSize: 20),
                    )),
                    const SliverToBoxAdapter(child: SizedBox(height: 10)),
                    SliverToBoxAdapter(
                        child: Row(children: [
                      Lottie.asset(GLOBAL.GET_ICON_FROM_WMO_CODE(10, false),
                          width: 150, height: 150),
                      const Spacer(),
                      const Text('28°',
                          style: TextStyle(
                              fontSize: 80, fontWeight: FontWeight.bold))
                    ])),
                    const SliverToBoxAdapter(child: SizedBox(height: 20)),
                    const SliverToBoxAdapter(
                        child: Row(children: [
                      Spacer(),
                      CardData(iconName: FontAwesomeIcons.wind, data: '12%'),
                      Spacer(),
                      CardData(iconName: FontAwesomeIcons.cloud, data: '12%'),
                      Spacer(),
                      CardData(iconName: FontAwesomeIcons.droplet, data: '12%'),
                      Spacer(),
                    ])),
                    const SliverToBoxAdapter(child: SizedBox(height: 20)),
                    const SliverToBoxAdapter(child: Divider()),
                    const SliverToBoxAdapter(child: SizedBox(height: 20)),
                    
                    const SliverToBoxAdapter(
                        child: Text(
                      'Days',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    )),
                    SliverToBoxAdapter(
                        child: SizedBox(
                            height: 160,
                            child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  for (int i = 0; i < limit; i++)
                                    CardWeatherHorizontal(
                                        index: i,
                                        isCurrentDay:
                                            dailyIndex.currentDay == i,
                                        date:
                                            '${GLOBAL.DAYS[DateTime.parse(value['daily']['time'][i]).weekday - 1].substring(0, 3)} ${DateTime.parse(value['daily']['time'][i]).day}',
                                        value:
                                            '${value['daily']['temperature_2m_min'][i]}°/${value['daily']['temperature_2m_max'][i]}°',
                                        iconName: GLOBAL.GET_ICON_FROM_WMO_CODE(
                                            50, false)),
                                ]))),
                    const SliverToBoxAdapter(child: SizedBox(height: 50)),
                    SliverToBoxAdapter(
                        child: HourlyList(
                          range: 1,
                            day: DateTime.parse(
                                value['daily']['time'][dailyIndex.currentDay]),
                            value: value['hourly'])),
                    const SliverToBoxAdapter(child: SizedBox(height: 20)),
                    const SliverToBoxAdapter(
                        child: AirQuality(
                            currentQuality: 10, quality: [0, 12, 12])),
                    const SliverToBoxAdapter(child: SizedBox(height: 50)),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const LinearProgressIndicator();
            }));
  }
}
