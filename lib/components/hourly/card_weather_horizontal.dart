import 'package:flutter/material.dart';
import '../../utils/dependencies.dart';
import 'package:weather/providers/init.dart';

final class CardWeatherHorizontal extends StatelessWidget {
  /// This is the index of the selectionated day.
  ///
  /// This is used for change the background of the card.
  ///
  /// Represent the indexo of the card in the list of the day.
  final int index;

  /// This is the date of the card.
  final String date;

  /// This parameter represent a string asset that can build in a Lottie builder
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
    final dailyIndex = context.watch<DailyIndex>();
    final sized = MediaQuery.of(context).size;
    return InkWell(
        splashColor: Colors.transparent,
        //borderRadius: const BorderRadius.all(Radius.circular(15)),
        onTap: () {
          dailyIndex.controller.animateTo(sized.width * (index),
              duration: const Duration(milliseconds: 1),
              curve: Curves.decelerate);
          dailyIndex.setCurrentDay(index);
        },
        child: Card(
          //color: Colors.black,
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
