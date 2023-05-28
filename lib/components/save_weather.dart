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
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isPlaying = _animationController!.isAnimating;

    return Column(
      children: [
        Lottie.asset(
          'assets/icons/star.json',
          height: 200,
          width: 200,
          controller: _animationController!,
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              if (isPlaying) {
                _animationController!.stop();
              } else {
                _animationController!.repeat();
              }
            });
          },
          child: Text(isPlaying ? 'Stop Animation' : 'Start Animation'),
        ),
      ],
    );
  }
}
