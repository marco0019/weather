import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/providers/init.dart';
import 'package:weather/utils/dependencies.dart';

class RecentlyCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const RecentlyCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherProvider>();
    final menu = context.watch<MenuProvider>();
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      onTap: () {
        weather.setData(
            ti: data['place'],
            cCode: data['country'],
            lat: data['latitude'],
            lon: data['longitude']);
        menu.setIndex(0);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Text(data['place']),
            const Icon(FontAwesomeIcons.receipt),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
