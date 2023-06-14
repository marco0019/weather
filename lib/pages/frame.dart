import 'package:flutter/material.dart';
import 'package:weather/components/components.dart';
import 'package:weather/pages/pages.dart';
import 'package:weather/providers/providers.dart';
import 'package:weather/utils/dependencies.dart';

class Frame extends StatefulWidget {
  const Frame({super.key});

  @override
  createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherProvider>();
    final List<Widget> pages = [
      const Home(),
      SearchPlace(wp: weather),
      PlacesSaved(wp: weather),
      const Settings()
    ];
    return DefaultTabController(
        length: pages.length,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          bottomNavigationBar: const BottomCustomBar(),
          body: pages[weather.currentIndex],
        ));
  }
}
