import 'package:flutter/material.dart';
import 'package:weather/components/init.dart';
import 'package:weather/pages/tabs/home.dart';
import 'package:weather/pages/init.dart';
import 'package:weather/providers/init.dart';
import 'package:weather/utils/dependencies.dart';

class Frame extends StatefulWidget {
  const Frame({super.key});
  @override
  createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  int currentIndex = 0;
  final List<Widget> pages = const [
    Home(),
    SearchPlace(),
    PlacesSaved(),
    Settings()
  ];
  @override
  Widget build(BuildContext context) {
    final menu = context.watch<MenuProvider>();
    return DefaultTabController(
        length: pages.length,
        child: Scaffold(
          bottomNavigationBar: const BottomCustomBar(),
          body: pages[menu.currentIndex],
        ));
  }
}
