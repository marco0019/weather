import 'package:flutter/material.dart';
import 'package:weather/utils/dependecies.dart';

class RandomLoading extends StatelessWidget {
  final String description;
  const RandomLoading({super.key, required this.description});

  @override
  Widget build(BuildContext context) => Center(
          child: Card(
              child: Center(
                  child: Column(children: [
        Lottie.asset(GLOBAL.GET_RANDOM_LOADING_ANIMATION()),
        Text(description)
      ]))));
}
