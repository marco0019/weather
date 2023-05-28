import 'package:flutter/material.dart';
import 'package:weather/components/init.dart';
import 'package:weather/providers/init.dart';
import '../utils/dependecies.dart';

class Home extends StatefulWidget {
  final String title;
  final double latitude;
  final double longitude;
  final String countryCode;

  const Home(
      {super.key,
      required this.latitude,
      required this.longitude,
      required this.title,
      required this.countryCode});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherProvider>();
    final isDarkMode = context.watch<ThemeModel>().isDarkMode;
    final dailyIndex = context.watch<DailyIndex>();
    return Scaffold(
        drawer: const DrawerBar(),
        body: FutureBuilder(
            future: weather.fetchWeather(
                latitude: widget.latitude, longitude: widget.longitude),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var value = Map<String, dynamic>.from(snapshot.data as Map);
                final limit = value['daily']['time'].length;
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      actions: [
                        SaveWeather(
                            place: widget.title,
                            lat: widget.latitude,
                            lon: widget.longitude)
                      ],
                      centerTitle: true,
                      pinned: true,
                      expandedHeight: 200,
                      //leading: const ChangeTheme(),
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        expandedTitleScale: 2,
                        //background: Container(color: Colors.pink),
                        title: Text(
                          widget.title.replaceAll('', ' ').toUpperCase(),
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: isDarkMode ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 10)),
                    SliverToBoxAdapter(
                        child: CurrentDay(info: value['hourly'])),
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
                    const SliverToBoxAdapter(child: SizedBox(height: 50)),
                    SliverToBoxAdapter(
                        child: SizedBox(
                            height: 880,
                            child: PageView.builder(
                                onPageChanged: (indexChanged) =>
                                    dailyIndex.setCurrentDay(indexChanged),
                                controller: dailyIndex.controller,
                                scrollDirection: Axis.horizontal,
                                itemCount: limit,
                                itemBuilder: (context, index) => HourlyList(
                                    range: 2,
                                    day: DateTime.parse(
                                        value['daily']['time'][index]),
                                    value: value['hourly'])))),
                    const SliverToBoxAdapter(child: SizedBox(height: 20))
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              }
              return Center(child: Lottie.asset('assets/loadings/1.json'));
              //return const LinearProgressIndicator();
            }));
  }
}
