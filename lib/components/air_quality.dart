import 'package:flutter/material.dart';

class AirQuality extends StatefulWidget {
  final double currentQuality;
  final List<double> quality;
  const AirQuality(
      {super.key, required this.currentQuality, required this.quality});

  @override
  State<AirQuality> createState() => _AirQualityState();
}

class _AirQualityState extends State<AirQuality> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Row(
                children: [
                  Text('Air quality',
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.start),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(widget.currentQuality.toString()),
                  const Spacer(),
                  Text(widget.currentQuality.toString()),
                  const SizedBox(width: 10),
                  Text(widget.currentQuality.toString()),
                ],
              ),
              const SizedBox(height: 20)
            ],
          )),
    );
  }
}
