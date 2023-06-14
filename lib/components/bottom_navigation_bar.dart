import 'package:flutter/material.dart';
import 'package:weather/providers/providers.dart';
import 'package:weather/utils/dependencies.dart';

class BottomCustomBar extends StatelessWidget {
  const BottomCustomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherProvider>();
    final theme = context.watch<ThemeModel>();
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
        style: GnavStyle.google,
        gap: 8,
        backgroundColor: theme.isDarkMode
            ? Colors.grey[900]!.withOpacity(.975)
            : Colors.grey[200]!.withOpacity(.975),
        //activeColor: Colors.black,
        iconSize: 24,
        haptic: true,
        color: theme.isDarkMode ? Colors.grey[400]! : Colors.grey[800]!,
        tabMargin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        duration: const Duration(milliseconds: 400),
        //tabBackgroundColor: Colors.grey[100]!,
        //tabBackgroundColor: Colors.grey[100]!,
        //tabActiveBorder: Border.all(),
        //color: Colors.black,
        selectedIndex: weather.currentIndex,
        onTabChange: (int index) {
          if (index != 0 || weather.latitude != null) {
            weather.setIndex(index);
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
