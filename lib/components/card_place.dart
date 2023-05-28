import 'package:flutter/material.dart';
import 'package:weather/utils/dependencies.dart';

class CardPlace extends StatelessWidget {
  final String countryCode;
  final String place;

  const CardPlace({super.key, required this.countryCode, required this.place});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(children: [
      Flag.fromString(
        countryCode,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
      Text(place)
    ]));
  }
}
