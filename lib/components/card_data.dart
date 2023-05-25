import 'package:flutter/material.dart';

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
        Text(data)
      ],
    );
  }
}
