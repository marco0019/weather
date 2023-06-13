import 'package:flutter/material.dart';
import 'package:weather/components/init.dart';
import 'package:weather/pages/meteogram.dart';
import 'package:weather/providers/init.dart';
import 'package:weather/providers/local_storage.dart';
import '../../components/segmented_button.dart';
import '../../utils/dependencies.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    LocalStorage.contains('PlaceSaved', latitude: 0, longitude: 0);
  }

  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherProvider>();
    final day = context.watch<HomeProvider>();
    return FutureBuilder(
        future: weather.weather,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var value = Map<String, dynamic>.from(snapshot.data as Map);
            final limit = value['daily']['time'].length;
            return FutureBuilder(
                future: weather.airQuality,
                builder: (context, snapshot1) {
                  if (snapshot1.hasData) {
                    return CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          leading: FutureBuilder(
                              future: LocalStorage.contains('PlaceSaved',
                                  latitude: weather.latitude!,
                                  longitude: weather.longitude!),
                              builder: (context, contain) => IconButton(
                                  onPressed: () {
                                    if (contain.hasData) {
                                      if (contain.data!) {
                                        LocalStorage.getIdFromCoordinates(
                                                'PlaceSaved',
                                                latitude: weather.latitude!,
                                                longitude: weather.longitude!)
                                            .then((value) =>
                                                LocalStorage.delete(
                                                    table: 'PlaceSaved',
                                                    id: value));
                                        //LocalStorage.delete(
                                        //     table: 'PlaceSaved', id: 0);
                                      } else {
                                        LocalStorage.insertData('PlaceSaved',
                                            place: weather.title,
                                            country: weather.countryCode,
                                            longitude: weather.longitude!,
                                            latitude: weather.latitude!,
                                            once: true);
                                      }
                                    }
                                  },
                                  icon: iconFromSnapshot(contain))),
                          centerTitle: true,
                          pinned: true,
                          expandedHeight: 200,
                          flexibleSpace: FlexibleSpaceBar(
                              centerTitle: true,
                              expandedTitleScale: 2,
                              title: InkWell(
                                  onTap: () => weather.setIndex(1),
                                  child: Text(
                                    weather.title.toUpperCase(),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .primaryColorLight),
                                  ))),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 10)),
                        SliverToBoxAdapter(
                            child: CurrentDay(info: value['hourly'])),
                        const SliverToBoxAdapter(child: SizedBox(height: 20)),
                        const SliverToBoxAdapter(child: Divider()),
                        const SliverToBoxAdapter(child: SizedBox(height: 20)),
                        SliverToBoxAdapter(
                            child: DailyListHorizontal(
                                limit: limit,
                                value: value['daily'],
                                currentIndex: day.currentDay)),
                        const SliverToBoxAdapter(child: SizedBox(height: 10)),
                        const SliverToBoxAdapter(child: SingleChoice()),
                        SliverToBoxAdapter(
                            child: SizedBox(
                                height: (day.currentDay == 0
                                        ? 24 - DateTime.now().hour
                                        : 24 / day.range) *
                                    73,
                                child: PageView.builder(
                                    onPageChanged: (indexChanged) =>
                                        day.setCurrentDay(indexChanged),
                                    controller: day.controller,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: limit,
                                    itemBuilder: (context, index) => HourlyList(
                                        airValue: snapshot1.data!['hourly'],
                                        range: day.range,
                                        day: DateTime.parse(
                                            value['daily']['time'][index]),
                                        value: value['hourly'])))),
                        const SliverToBoxAdapter(child: SizedBox(height: 20)),
                        SliverToBoxAdapter(
                            child: InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MeteoGram(
                                            hourlyData: value['hourly'],
                                            airData:
                                                snapshot1.data!['hourly']))),
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
                                      Icon(FontAwesomeIcons.angleRight,
                                          size: 15)
                                    ])))),
                        SliverToBoxAdapter(
                            child: Card(
                                child: SizedBox(
                                    height: 300,
                                    child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: ChartLineExample(
                                            linesGradient: const [
                                              LinearGradient(colors: [
                                                Colors.red,
                                                Colors.pink
                                              ]),
                                              LinearGradient(colors: [
                                                Colors.blue,
                                                Colors.purple
                                              ])
                                            ],
                                            lines: [
                                              value['daily'],
                                              value['daily']
                                            ],
                                            horizontalAxisName: 'time',
                                            verticalAxisNames: const [
                                              'temperature_2m_max',
                                              'temperature_2m_min'
                                            ]))))),
                        const SliverToBoxAdapter(child: SizedBox(height: 80))
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('${snapshot.error}'));
                  }
                  return const RandomLoading(
                      title: 'Loading', description: '', min: 6);
                });
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const RandomLoading(title: 'Loading', description: '', min: 6);
        });
  }

  Widget iconFromSnapshot(snapshot) {
    if (snapshot.hasData) {
      if (snapshot.data!) {
        return const Icon(FontAwesomeIcons.solidStar);
      } else {
        return const Icon(FontAwesomeIcons.star);
      }
    }
    return const Icon(FontAwesomeIcons.star);
  }
}
