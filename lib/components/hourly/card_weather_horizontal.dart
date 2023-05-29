import 'package:flutter/material.dart';
import '../../utils/dependencies.dart';
import 'package:weather/providers/init.dart';

final class CardWeatherHorizontal extends StatelessWidget {
  final int index;

  final String date;

  final String iconName;
  final String value;
  final bool isCurrentDay;

  const CardWeatherHorizontal(
      {super.key,
      required this.index,
      required this.date,
      required this.value,
      required this.iconName,
      required this.isCurrentDay});

  @override
  Widget build(BuildContext context) {
    final dailyIndex = context.watch<HomeProvider>();
    return InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          dailyIndex.controller.jumpToPage(index);
          dailyIndex.setCurrentDay(index);
        },
        child: Card(
          color: isCurrentDay ? Colors.blue : null,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                children: [
                  Text(date,
                      style:
                          TextStyle(color: isCurrentDay ? Colors.white : null)),
                  const SizedBox(height: 15),
                  Lottie.asset(iconName, width: 40, height: 40),
                  const SizedBox(height: 15),
                  Text(value,
                      style:
                          TextStyle(color: isCurrentDay ? Colors.white : null))
                ],
              )),
        ));
  }
}
