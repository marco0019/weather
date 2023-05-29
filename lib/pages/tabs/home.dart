import 'package:flutter/material.dart';
import 'package:weather/components/air_quality.dart';
import 'package:weather/components/init.dart';
import 'package:weather/providers/init.dart';
import '../../components/segmented_button.dart';
import '../../utils/dependencies.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherProvider>();
    final isDarkMode = context.watch<ThemeModel>().isDarkMode;
    final dailyIndex = context.watch<HomeProvider>();
    final menu = context.watch<MenuProvider>();
    return FutureBuilder(
        future: weather.fetchWeather(
            latitude: weather.latitude, longitude: weather.longitude),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var value = Map<String, dynamic>.from(snapshot.data as Map);
            final limit = value['daily']['time'].length;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  leading: const Icon(FontAwesomeIcons.star),
                  centerTitle: true,
                  pinned: true,
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      expandedTitleScale: 2,
                      title: InkWell(
                          onTap: () => menu.setIndex(1),
                          child: Text(weather.title.toUpperCase(),
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.black)))),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverToBoxAdapter(child: CurrentDay(info: value['hourly'])),
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
                    child: DailyListHorizontal(
                        limit: limit,
                        value: value['daily'],
                        currentIndex: dailyIndex.currentDay)),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                const SliverToBoxAdapter(child: SingleChoice()),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                SliverToBoxAdapter(
                    child: SizedBox(
                        height: 860,
                        child: PageView.builder(
                            onPageChanged: (indexChanged) =>
                                dailyIndex.setCurrentDay(indexChanged),
                            controller: dailyIndex.controller,
                            scrollDirection: Axis.horizontal,
                            itemCount: limit,
                            itemBuilder: (context, index) => HourlyList(
                                range: dailyIndex.range,
                                day: DateTime.parse(
                                    value['daily']['time'][index]),
                                value: value['hourly'])))),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                SliverToBoxAdapter(
                    child: InkWell(
                        onTap: () {},
                        child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(children: [
                              Text('Temperature',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                              Spacer(),
                              Text('View all'),
                              SizedBox(width: 10),
                              Icon(FontAwesomeIcons.angleRight, size: 15)
                            ])))),
                SliverToBoxAdapter(
                    child: Card(
                        elevation: 2,
                        child: SizedBox(
                            height: 300,
                            child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: ChartLineExample(
                                    linesGradient: const [
                                      LinearGradient(
                                          colors: [Colors.red, Colors.pink]),
                                      LinearGradient(
                                          colors: [Colors.blue, Colors.purple])
                                    ],
                                    lines: [value['daily'], value['daily']],
                                    horizontalAxisName: 'time',
                                    verticalAxisNames: const [
                                      'temperature_2m_max',
                                      'temperature_2m_min'
                                    ]))))),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                SliverToBoxAdapter(
                    child: InkWell(
                        onTap: () {},
                        child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(children: [
                              Text('Air quality',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                              Spacer(),
                              Text('View all'),
                              SizedBox(width: 10),
                              Icon(FontAwesomeIcons.angleRight, size: 15)
                            ])))),
                SliverToBoxAdapter(
                    child: AirQuality(
                  latitude: weather.latitude,
                  longitude: weather.longitude,
                ))
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return Center(child: Lottie.asset('assets/loadings/1.json'));
        });
  }
}
