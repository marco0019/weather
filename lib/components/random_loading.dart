import 'package:flutter/material.dart';
import 'package:weather/utils/dependencies.dart';

class RandomLoading extends StatelessWidget {
  final String description;
  final String title;
  final int min, max;

  const RandomLoading(
      {super.key,
      required this.title,
      required this.description,
      this.min = 0,
      this.max = 7});

  @override
  Widget build(BuildContext context) => Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(height: 10),
        Text(title,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        Text(description, textAlign: TextAlign.center),
        Lottie.asset(GLOBAL.GET_RANDOM_LOADING_ANIMATION(min: min, max: max)),
      ]));
}
/*
Center(
          child: Card(
              child: Center(
                  child: Column(children: [
        const SizedBox(height: 10),
        Text(title,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        Text(description, textAlign: TextAlign.center),
        Lottie.asset(GLOBAL.GET_RANDOM_LOADING_ANIMATION()),
      ]))));
}
*/
