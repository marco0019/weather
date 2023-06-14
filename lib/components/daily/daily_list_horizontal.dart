import 'package:flutter/cupertino.dart';
import 'package:weather/components/components.dart';
import 'package:weather/utils/dependencies.dart';

class DailyListHorizontal extends StatelessWidget {
  final int limit;
  final int currentIndex;
  final Map<String, dynamic> value;

  const DailyListHorizontal(
      {super.key,
      required this.limit,
      required this.value,
      required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 160,
        child: ListView(scrollDirection: Axis.horizontal, children: [
          for (int i = 0; i < limit; i++)
            CardWeatherHorizontal(
                index: i,
                isCurrentDay: currentIndex == i,
                date:
                    '${GLOBAL.DAYS[DateTime.parse(value['time'][i]).weekday - 1].substring(0, 3)} ${DateTime.parse(value['time'][i]).day}',
                value:
                    '${value['temperature_2m_min'][i]}°/${value['temperature_2m_max'][i]}°',
                iconName: GLOBAL.GET_ICON_FROM_WMO_CODE(
                    value['weathercode'][i], true)),
        ]));
  }
}
