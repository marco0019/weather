import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SaveWeather extends StatefulWidget {
  final String place;
  final double lat, lon;

  const SaveWeather(
      {super.key, required this.place, required this.lat, required this.lon});

  @override
  State<SaveWeather> createState() => _SaveWeatherState();
}

class _SaveWeatherState extends State<SaveWeather>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      Lottie.asset(controller: _controller, 'assets/icons/star.json',
          onLoaded: (animation) {
        _controller
          ..duration = animation.duration
          ..repeat(reverse: false);
      });
}
