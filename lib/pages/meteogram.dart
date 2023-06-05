import 'package:flutter/material.dart';
import 'package:weather/components/charts/chart_line.dart';

class MeteoGram extends StatelessWidget {
  final Map<String, dynamic> hourlyData;
  final Map<String, dynamic> airData;

  const MeteoGram({super.key, required this.hourlyData, required this.airData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverAppBar(
          //leading: const Icon(FontAwesomeIcons.star),
          centerTitle: true,
          pinned: true,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              expandedTitleScale: 2,
              title: Text(
                'Meteogram',
                style: TextStyle(color: Theme.of(context).primaryColorLight),
              ))),
      //for(Map<String, dynamic> graph in graphs)
      const SliverToBoxAdapter(child: Text('Temperature')),
      Graph(const LinearGradient(colors: [Colors.white, Colors.green]),
          'temperature_2m', hourlyData),
      const SliverToBoxAdapter(child: SizedBox(height: 50)),

      const SliverToBoxAdapter(child: Text('Apparent temperature')),
      Graph(const LinearGradient(colors: [Colors.white, Colors.green]),
          'apparent_temperature', hourlyData),
      const SliverToBoxAdapter(child: SizedBox(height: 50)),

      const SliverToBoxAdapter(child: Text('Precipitation')),
      Graph(const LinearGradient(colors: [Colors.white, Colors.green]),
          'precipitation', hourlyData),
      const SliverToBoxAdapter(child: SizedBox(height: 50)),

      const SliverToBoxAdapter(child: Text('Humidity')),
      Graph(const LinearGradient(colors: [Colors.white, Colors.green]),
          'relativehumidity_2m', hourlyData),
      const SliverToBoxAdapter(child: SizedBox(height: 50)),

      const SliverToBoxAdapter(child: Text('Surface pressure')),
      Graph(const LinearGradient(colors: [Colors.white, Colors.green]),
          'surface_pressure', hourlyData),
      const SliverToBoxAdapter(child: SizedBox(height: 50)),

      const SliverToBoxAdapter(child: Text('Ozone')),
      Graph(const LinearGradient(colors: [Colors.white, Colors.green]), 'ozone',
          airData),
      const SliverToBoxAdapter(child: SizedBox(height: 50)),

      const SliverToBoxAdapter(child: Text('PM 10')),
      Graph(const LinearGradient(colors: [Colors.white, Colors.green]), 'pm10',
          airData),
      const SliverToBoxAdapter(child: SizedBox(height: 50)),

      const SliverToBoxAdapter(child: Text('PM 25')),

      Graph(const LinearGradient(colors: [Colors.white, Colors.green]), 'pm2_5',
          airData),
      const SliverToBoxAdapter(child: SizedBox(height: 50)),

      const SliverToBoxAdapter(child: Text('Nitrogen dioxide')),
      Graph(const LinearGradient(colors: [Colors.white, Colors.green]),
          'nitrogen_dioxide', airData),
      const SliverToBoxAdapter(child: SizedBox(height: 50)),

      const SliverToBoxAdapter(child: Text('Sulphur dioxide')),
      Graph(const LinearGradient(colors: [Colors.white, Colors.green]),
          'sulphur_dioxide', airData),
      const SliverToBoxAdapter(child: SizedBox(height: 50)),

      const SliverToBoxAdapter(child: Text('European AQI')),
      Graph(const LinearGradient(colors: [Colors.white, Colors.green]),
          'european_aqi', airData),
    ]));
  }

  Widget Graph(LinearGradient gradient, String verticalData,
          Map<String, dynamic> horizontalData, {double margin = 50}) =>
      SliverToBoxAdapter(
          child: SizedBox(
              height: 300,
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ChartLineExample(
                      linesGradient: [gradient],
                      lines: [horizontalData],
                      horizontalAxisName: 'time',
                      verticalAxisNames: [verticalData]))));
}
