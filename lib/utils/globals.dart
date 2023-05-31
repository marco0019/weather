import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:weather/main.dart';
import 'package:weather/providers/init.dart';
import 'dependencies.dart';

class GLOBAL {
  static Random RAND = Random();
  static List<SingleChildWidget> PROVIDERS = [
    ChangeNotifierProvider(create: (_) => WeatherProvider()),
    ChangeNotifierProvider(create: (_) => ThemeModel()),
    ChangeNotifierProvider(create: (_) => HomeProvider()),
    ChangeNotifierProvider(create: (_) => MenuProvider())
  ];
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

  static Map<String, dynamic> GET_IQA_INFO(int code) {
    if (INCLUDE(0, 50, code)) {
      return {
        'color': Colors.green,
        'label': 'GOOD',
      };
    }
    if (INCLUDE(51, 100, code)) {
      return {'color': Colors.yellowAccent, 'label': 'MODERATA'};
    }
    if (INCLUDE(101, 150, code)) {
      return {
        'color': Colors.orange,
        'label': 'INSALUBRE PER GRUPPI SENSIBILI'
      };
    }
    if (INCLUDE(151, 200, code)) {
      return {'color': Colors.red, 'label': 'INSALUBRE'};
    }
    if (INCLUDE(201, 300, code)) {
      return {'color': Colors.purple, 'label': 'MOLTO INSALUBRE'};
    }
    return {
      'color': const Color.fromRGBO(65, 0, 0, 100),
      'label': 'PERICOLOSA'
    };
  }

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

  static double GET_AVERAGE_FROM_HOURLY_DATA(
      DateTime ref, List<DateTime> dates, List<double> values) {
    double sum = 0;
    int length = 0;
    for (int i = 0; i < dates.length; i++) {
      if (dates[i].year == ref.year &&
          dates[i].month == ref.month &&
          dates[i].day == ref.day) {
        sum += values[i];
        length++;
      }
    }
    return sum / length;
  }

  static List<String> AIR_STATES = [
    'Good',
    'Fair',
    'Moderate',
    'Poor',
    'Very poor',
    'Extremely poor'
  ];

  static String GET_WIND_DIRECTION(int angle) => [
        'N',
        'NNE',
        'NE',
        'ENE',
        'E',
        'ESE',
        'SE',
        'SSE',
        'S',
        'SSW',
        'SW',
        'WSW',
        'W',
        'WNW',
        'NW'
      ][(angle ~/ 22.5) % 15];
  static List<Color> AIR_QUALITY_COLORS = [
    Colors.lightBlueAccent,
    Colors.green,
    Colors.yellow,
    Colors.deepOrangeAccent,
    Colors.red,
    Colors.deepPurple
  ];

  static Color GET_COLOR_OF_AQI(int aqi) => AIR_QUALITY_COLORS[aqi ~/ 20];

  static List<int> GET_QUALITY_OF_AIR(List<int> values) {
    final List<int> result = [];
    final indexes = [
      [0, 10, 20, 25, 50, 75, 800], // pm25
      [0, 20, 40, 50, 100, 150, 1200], // pm10
      [0, 40, 90, 120, 230, 340, 1000], //NO2
      [0, 50, 100, 130, 240, 380, 800], //O3
      [0, 100, 200, 350, 500, 750, 1250] //SO2
    ];
    for (int i = 0; i < values.length; i++) {
      result.add(GET_LAST_INDEX(indexes[i], values[i]));
    }
    int sum = 0;
    for (int item in result) sum += item;
    result.add(sum ~/ values.length);
    return result;
  }

  static int GET_LAST_INDEX(List<int> list, int target) {
    for (int i = 0; i < list.length; i++) {
      if (list[i] > target) return i - 1;
    }
    return 0;
  }

  static String GET_RAIN_CODE(double rain) {
    if (rain == 0) return 'assenti';
    if (rain <= 0.5) return 'moderate';
    if (rain <= 1) return 'consistenti';
    return 'abbondanti';
  }
}
