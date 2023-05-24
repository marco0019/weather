import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeatherCard extends StatelessWidget {
  final String weatherIconUrl;
  final String min;
  final String max;
  final String day;
  final String wind;
  final int precipitationProbability;
  final int weatherCode;
  final Widget pageRedirect;

  const WeatherCard(
      {super.key,
      required this.weatherCode,
      required this.weatherIconUrl,
      required this.min,
      required this.max,
      required this.day,
      required this.wind,
      required this.precipitationProbability,
      required this.pageRedirect});

  @override
  Widget build(BuildContext context) => Card(
          child: InkWell(
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => pageRedirect)),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(precipitationProbability.toString()),
              Lottie.asset(weatherIconUrl, width: 40, height: 40),
              const SizedBox(width: 10),
              Text(
                day,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(min),
              const SizedBox(width: 10),
              Text(max),
            ],
          ),
        ),
      ));
}
/*
    Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(precipitationProbability.toString()),
              Lottie.network(weatherIconUrl, width: 40, height: 40),
              const SizedBox(width: 10),
              Text(
                day,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(min),
              Text(max),
            ],
          ),
        ),
      );*/