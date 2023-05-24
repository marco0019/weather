import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  final String title;
  final String currentTemp;
  final int weatherCode;
  const CardInfo(
      {super.key,
      required this.title,
      required this.currentTemp,
      required this.weatherCode});
  @override
  Widget build(BuildContext context) => Card(
      margin: const EdgeInsets.fromLTRB(0, 40, 0, 40),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Text(title),
          Text(
            '$currentTemp C°',
            style: const TextStyle(fontSize: 20),
          ),
        ]),
      ));
}
