import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:weather/main.dart';
import 'package:weather/pages/init.dart';
import 'package:weather/providers/init.dart';
import 'dependecies.dart';

class GLOBAL {
  static Random RAND = Random();
  static List<SingleChildWidget> PROVIDERS = [
    ChangeNotifierProvider(create: (_) => WeatherProvider()),
    ChangeNotifierProvider(create: (_) => ThemeModel()),
    ChangeNotifierProvider(create: (_) => DailyIndex()),
    //ChangeNotifierProvider(create: (_) => GeoLocatorProvider())
  ];
  static Map<String, Widget Function(BuildContext)> ROUTES = {
    '/search': (context) => const SearchPlace(),
    '/place-saved': (context) => const PlacesSaved(),
    '/settings': (context) => const Settings()
  };
  static List<String> DAYS = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  static List<String> MOUNTHS = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'November',
    'December'
  ];

  static MultiProvider MAIN =
      MultiProvider(providers: PROVIDERS, child: const Main());

  static Uri GET_OPEN_METEO_DATA(
          {required double latitude, required double longitude}) =>
      Uri.parse(
          "${dotenv.env['API_METEO_URL']}&latitude=$latitude&longitude=$longitude");

  static String GET_LOCATION_FROM_TEXT(String city) =>
      '${dotenv.env['API_LOCATION_IQ_BASE_URL']}?key=${dotenv.env['API_LOCATION_IQ_KEY']}&q=$city';

  static String ANIMATION_INDENTIFIER(int index) =>
      './assets/animations/$index.json';

  static String GET_ICON_FROM_WMO_CODE(int code, bool isDay) {
    if (INCLUDE(0, 3, code)) return WEATHER_ICONS['chiaro']!(isDay);
    if (INCLUDE(4, 12, code)) return WEATHER_ICONS['nuvoloso-tanto']!(isDay);
    if (INCLUDE(13, 21, code)) return WEATHER_ICONS['pioggia']!(isDay);
    if (INCLUDE(22, 28, code)) return WEATHER_ICONS['neve']!(isDay);
    if (INCLUDE(29, 35, code)) return WEATHER_ICONS['tempesta']!(isDay);
    if (INCLUDE(36, 41, code)) return WEATHER_ICONS['neve']!(isDay);
    if (INCLUDE(42, 49, code)) return WEATHER_ICONS['solo-nuvoloso']!(isDay);
    if (INCLUDE(60, 65, code)) return WEATHER_ICONS['pioggia']!(isDay);
    if (INCLUDE(66, 79, code)) return WEATHER_ICONS['neve']!(isDay);
    if (INCLUDE(80, 84, code)) return WEATHER_ICONS['pioggia']!(isDay);
    if (INCLUDE(85, 90, code)) return WEATHER_ICONS['pioggia']!(isDay);
    return WEATHER_ICONS['solo-nuvoloso']!(isDay);
  }

  static bool INCLUDE(int min, int max, int num) => num >= min && num <= max;

  static Map<String, String Function(bool)> WEATHER_ICONS = {
    'chiaro': (bool isDay) =>
        isDay ? ANIMATION_INDENTIFIER(9) : ANIMATION_INDENTIFIER(8),
    'nuvolo-poco': (bool isDay) =>
        isDay ? ANIMATION_INDENTIFIER(11) : ANIMATION_INDENTIFIER(13),
    'pioggia': (bool isDay) =>
        isDay ? ANIMATION_INDENTIFIER(14) : ANIMATION_INDENTIFIER(2),
    'tempesta': (bool isDay) =>
        isDay ? ANIMATION_INDENTIFIER(4) : ANIMATION_INDENTIFIER(6),
    'nuvoloso-tanto': (bool isDay) =>
        isDay ? ANIMATION_INDENTIFIER(1) : ANIMATION_INDENTIFIER(10),
    'neve': (bool isDay) =>
        isDay ? ANIMATION_INDENTIFIER(3) : ANIMATION_INDENTIFIER(5),
    'solo-nuvoloso': (bool isDay) => ANIMATION_INDENTIFIER(15),
    'solo-neve': (bool isDay) => ANIMATION_INDENTIFIER(7),
    'solo-tuoni': (bool isDay) => ANIMATION_INDENTIFIER(12)
  };

  static int GET_INDEX_NOW_FROM_DATE(Map<String, dynamic> value) {
    int limit = (value['time'] as List<dynamic>).length;
    final DateTime now = DateTime.now();
    for (int i = 0; i < limit; i++) {
      DateTime date = DateTime.parse(value['time'][i]);
      if (now.year == date.year &&
          now.month == date.month &&
          now.hour == date.hour) {
        return i;
      }
    }
    return 0;
  }

  static String GET_RANDOM_LOADING_ANIMATION() =>
      'assets/loadings/${RAND.nextInt(5) + 1}.json';
  static String CONCAT_WITH_SPLIT(String text,
      {required List<int> include,
      String splitChar = ',',
      String charUnion = ', '}) {
    final word = text.split(splitChar);
    String phrase = '';
    for (int index in include) {
      phrase += word[index] + charUnion;
    }
    return phrase;
  }
}
//latitude=52.52&longitude=13.41&hourly=temperature_2m,precipitation_probability,rain,weathercode,visibility,windspeed_10m,winddirection_10m,is_day&daily=temperature_2m_max,temperature_2m_min&current_weather=true&timezone=Europe%2FBerlin
