import 'package:flutter/material.dart';
import 'package:weather/utils/dependecies.dart';

class CardData extends StatelessWidget {
  final String iconName;
  final Widget data;

  const CardData({super.key, required this.iconName, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: .5,
          child: Lottie.asset(iconName, width: 80, height: 80),
        ),
        data
      ],
    );
  }
}
