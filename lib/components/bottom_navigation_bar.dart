import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:weather/providers/init.dart';
import 'package:weather/utils/dependencies.dart';

class BottomCustomBar extends StatelessWidget {
  const BottomCustomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherProvider>();
    var tabs = [
      {
        'title': 'Home',
        'icon': FontAwesomeIcons.house,
        'selectedIcon': FontAwesomeIcons.house,
      },
      {
        'title': 'Search',
        'icon': FontAwesomeIcons.magnifyingGlass,
        'selectedIcon': FontAwesomeIcons.magnifyingGlass,
      },
      {
        'title': 'Saved',
        'icon': Icons.bookmark,
        'selectedIcon': Icons.bookmark_border,
      },
      {
        'title': 'Settings',
        'icon': FontAwesomeIcons.gear,
        'selectedIcon': FontAwesomeIcons.gear
      },
    ];
    return GNav(
      //rippleColor: Colors.grey[300]!,
      //hoverColor: Colors.grey[100]!,
        gap: 8,
        backgroundColor: Colors.grey.withOpacity(.25),
        //activeColor: Colors.black,
        iconSize: 24,
        haptic: true,
        tabMargin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        duration: const Duration(milliseconds: 400),
        //tabBackgroundColor: Colors.grey[100]!,
        //tabBackgroundColor: Colors.grey[100]!,
        //tabActiveBorder: Border.all(),
        //color: Colors.black,
        selectedIndex: weather.currentIndex,
        onTabChange: (int index) {
          if (index != 0) {
            weather.setIndex(index);
          }
          else if (weather.latitude != null && weather.longitude != null) {
            weather.setIndex(index);
          }
          else {
            weather.setIndex(0);
          }
        },
        tabs: [
          for (int i = 0; i < tabs.length; i++)
            GButton(
                icon: tabs[i]['icon'] as IconData,
                text: tabs[i]['title'] as String)
        ]);
  }
}
/*NavigationBar(
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
      destinations: [
        for (int i = 0; i < tabs.length; i++)
          NavigationDestination(
            icon: Icon(tabs[i]['icon'] as IconData),
            selectedIcon:
                Icon(tabs[i]['icon'] as IconData, color: Colors.white),
            label: tabs[i]['title'] as String,
          ),
      ],
    );*/
