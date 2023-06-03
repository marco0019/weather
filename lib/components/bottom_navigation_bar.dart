import 'package:flutter/material.dart';
import 'package:weather/providers/init.dart';
import 'package:weather/utils/dependencies.dart';

class BottomCustomBar extends StatelessWidget {
  const BottomCustomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final menu = context.watch<MenuProvider>();
    final weather = context.watch<WeatherProvider>();
    return NavigationBar(
      animationDuration: const Duration(milliseconds: 400),
      height: 60,
      indicatorColor: Theme.of(context).primaryColor.withOpacity(.8),
      onDestinationSelected: (int index) {
        if (index == 0) {
          if (weather.latitude != null && weather.longitude != null) {
            menu.setIndex(index);
          }
        } else {
          menu.setIndex(index);
        }
      },
      selectedIndex: menu.currentIndex,
      destinations: const [
        NavigationDestination(
          icon: Icon(FontAwesomeIcons.house),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(FontAwesomeIcons.magnifyingGlass),
          label: 'Search',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.bookmark),
          icon: Icon(Icons.bookmark_border),
          label: 'Saved',
        ),
        NavigationDestination(
          selectedIcon: Icon(FontAwesomeIcons.gear),
          icon: Icon(FontAwesomeIcons.gear),
          label: 'Settings',
        ),
      ],
    );
  }
}
/*
SafeArea(
        child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            height: 75,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(24))),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 36,
                      height: 36,
                      child: IconButton(
                          color: menu.currentIndex == 1
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          onPressed: () {
                            menu.setIndex(0);
                          },
                          icon: const Icon(FontAwesomeIcons.house))),
                  SizedBox(
                      width: 36,
                      height: 36,
                      child: IconButton(
                          color: menu.currentIndex == 1
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          onPressed: () {
                            menu.setIndex(1);
                          },
                          icon: const Icon(FontAwesomeIcons.magnifyingGlass))),
                  SizedBox(
                      width: 36,
                      height: 36,
                      child: IconButton(
                          color: menu.currentIndex == 1
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          onPressed: () {
                            menu.setIndex(2);
                          },
                          icon: const Icon(FontAwesomeIcons.bookmark))),
                  SizedBox(
                      width: 36,
                      height: 36,
                      child: IconButton(
                          color: menu.currentIndex == 1
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          onPressed: () {
                            menu.setIndex(3);
                          },
                          icon: const Icon(FontAwesomeIcons.gear))),
                ])));
NavigationBar(
      height: 60,
      onDestinationSelected: (int index) => menu.setIndex(index),
      selectedIndex: menu.currentIndex,
      destinations: const [
        NavigationDestination(
          icon: Icon(FontAwesomeIcons.house),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(FontAwesomeIcons.magnifyingGlass),
          label: 'Search',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.bookmark),
          icon: Icon(Icons.bookmark_border),
          label: 'Saved',
        ),
        NavigationDestination(
          selectedIcon: Icon(FontAwesomeIcons.gear),
          icon: Icon(FontAwesomeIcons.gear),
          label: 'Settings',
        ),
      ],
    );*/
