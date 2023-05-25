import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:weather/main.dart';
import 'package:weather/providers/daily_index.dart';
import 'package:weather/providers/http_requests.dart';
import 'package:weather/providers/theme.dart';

class GLOBAL {
  static List<SingleChildWidget> PROVIDERS = [
    ChangeNotifierProvider(create: (_) => HttpRequest()),
    ChangeNotifierProvider(create: (_) => ThemeModel()),
    ChangeNotifierProvider(create: (_) => DailyIndex())
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
  static const String WEATHER_DEFAULT_REQUEST =
      "https://api.open-meteo.com/v1/forecast?latitude=42.13&longitude=12.13&hourly=temperature_2m,precipitation_probability,precipitation,rain,weathercode,visibility,windspeed_10m,winddirection_10m,is_day&daily=weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset,precipitation_sum,rain_sum,precipitation_probability_max,winddirection_10m_dominant&timezone=auto";
  static const String API_WEATHER_URL =
      "https://api.open-meteo.com/v1/forecast?";
  static String ANIMATION_INDENTIFIER(int index) => './assets/animations/$index.json';
  static Map<String, String Function(bool)> WEATHER_ICONS_WITH_DAY = {
    'chiaro': (bool isDay) => isDay ? ANIMATION_INDENTIFIER(8) : ANIMATION_INDENTIFIER(7),
    'nuvolo-poco': (bool isDay) =>
        isDay ? ANIMATION_INDENTIFIER(10) : ANIMATION_INDENTIFIER(12),
    'pioggia': (bool isDay) => isDay ? ANIMATION_INDENTIFIER(13) : ANIMATION_INDENTIFIER(1),
    'tempesta': (bool isDay) => isDay ? ANIMATION_INDENTIFIER(3) : ANIMATION_INDENTIFIER(5),
    'nuvoloso-tanto': (bool isDay) =>
        isDay ? ANIMATION_INDENTIFIER(0) : ANIMATION_INDENTIFIER(9),
    'neve': (bool isDay) => isDay ? ANIMATION_INDENTIFIER(2) : ANIMATION_INDENTIFIER(4),
    'solo-nuvoloso': (bool isDay) => ANIMATION_INDENTIFIER(14),
    'solo-neve': (bool isDay) => ANIMATION_INDENTIFIER(6),
    'solo-tuoni': (bool isDay) => ANIMATION_INDENTIFIER(11)
  };

//
  static String GET_ICON_FROM_WMO_CODE(int code, bool isDay) {
    if (INCLUDE(0, 3, code)) return WEATHER_ICONS_WITH_DAY['chiaro']!(isDay);
    if (INCLUDE(4, 12, code))
      return WEATHER_ICONS_WITH_DAY['nuvoloso-tanto']!(isDay);
    if (INCLUDE(13, 21, code)) return WEATHER_ICONS_WITH_DAY['pioggia']!(isDay);
    if (INCLUDE(22, 28, code)) return WEATHER_ICONS_WITH_DAY['neve']!(isDay);
    if (INCLUDE(29, 35, code))
      return WEATHER_ICONS_WITH_DAY['tempesta']!(isDay);
    if (INCLUDE(36, 41, code)) return WEATHER_ICONS_WITH_DAY['neve']!(isDay);
    if (INCLUDE(42, 49, code))
      return WEATHER_ICONS_WITH_DAY['solo-nuvoloso']!(isDay);
    if (INCLUDE(60, 65, code)) return WEATHER_ICONS_WITH_DAY['pioggia']!(isDay);
    if (INCLUDE(66, 79, code)) return WEATHER_ICONS_WITH_DAY['neve']!(isDay);
    if (INCLUDE(80, 84, code)) return WEATHER_ICONS_WITH_DAY['pioggia']!(isDay);
    if (INCLUDE(85, 90, code)) return WEATHER_ICONS_WITH_DAY['pioggia']!(isDay);
    return WEATHER_ICONS_WITH_DAY['pioggia']!(isDay);
  }

  static bool INCLUDE(int min, int max, int num) => num >= min && num <= max;
}
//latitude=52.52&longitude=13.41&hourly=temperature_2m,precipitation_probability,rain,weathercode,visibility,windspeed_10m,winddirection_10m,is_day&daily=temperature_2m_max,temperature_2m_min&current_weather=true&timezone=Europe%2FBerlin
