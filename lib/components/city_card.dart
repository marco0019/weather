import 'package:flutter/material.dart';
import 'package:weather/providers/init.dart';
import 'package:weather/utils/dependencies.dart';

class CityCard extends StatelessWidget {
  final String countryCode;
  final String country;
  final String place;
  final double lat;
  final double lon;
  final String timezone;

  const CityCard(
      {super.key,
      required this.countryCode,
      required this.place,
      required this.country,
      required this.lat,
      required this.lon,
      required this.timezone});

  @override
  Widget build(BuildContext context) {
    final weather = context.read<WeatherProvider>();
    final menu = context.read<MenuProvider>();
    return InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        onTap: () {
          weather.setData(ti: place, cCode: countryCode, lat: lat, lon: lon);
          menu.setIndex(0);
        },
        child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Image.asset(
                        'icons/flags/png/${countryCode.trim().toLowerCase()}.png',
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                        package: 'country_icons')),
                const SizedBox(width: 10),
                Expanded(
                    child: Text('$place, $country',
                        overflow: TextOverflow.ellipsis, maxLines: 1)),
                //const Spacer(),
                Text('${lat ~/ 1}° E', textAlign: TextAlign.end),
                const SizedBox(width: 10),
                Text('${lon ~/ 1}° N', textAlign: TextAlign.end)
              ],
            )));
  }
}
