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
      borderRadius: BorderRadius.all(Radius.circular(10)),
      onTap: () {
        dailyIndex.controller.jumpToPage(index);
        dailyIndex.setCurrentDay(index);
      },
      child: Container(
          decoration: BoxDecoration(
              color: isCurrentDay
                  ? Theme.of(context).primaryColor.withOpacity(.4)
                  : null,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            children: [
              Text(date,
                  style: TextStyle(color: isCurrentDay ? Colors.white : null)),
              //const Spacer(),
              Lottie.asset(iconName, width: 70, height: 70),
              //const Spacer(),
              Text(value,
                  style: TextStyle(color: isCurrentDay ? Colors.white : null))
            ],
          )),
    );
  }
}
