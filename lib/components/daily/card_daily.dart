import 'package:flutter/material.dart';
import '../../utils/dependecies.dart';

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
  Widget build(BuildContext context) => InkWell(
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => pageRedirect)),
        borderRadius: BorderRadius.circular(20),
        child: Card(
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                      value: precipitationProbability / 100),
                  const SizedBox(width: 10),
                  Lottie.asset(weatherIconUrl, width: 40, height: 40),
                  const SizedBox(width: 10),
                  Text(
                    day,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(min),
                  const SizedBox(width: 10),
                  Text(max),
                ],
              ),
            )),
      );
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
