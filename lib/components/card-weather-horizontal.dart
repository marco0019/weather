import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CardWeatherHorizontal extends StatelessWidget {
  final String date;
  final String iconName;
  final String value;

  const CardWeatherHorizontal(
      {super.key,
      required this.date,
      required this.value,
      required this.iconName});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: [
              Text(date),
              const SizedBox(height: 15),
              Lottie.asset(iconName, width: 40, height: 40),
              const SizedBox(height: 15),
              Text(value)
            ],
          )),
    );
  }
}
