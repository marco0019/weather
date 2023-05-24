import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CardData extends StatelessWidget {
  final IconData iconName;
  final String data;

  const CardData({super.key, required this.iconName, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Icon(iconName, color: Colors.blue)),
        ),
        const SizedBox(height: 0),
        Text(data)
      ],
    );
  }
}
