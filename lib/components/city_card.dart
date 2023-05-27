import 'package:flutter/material.dart';
import 'package:weather/pages/init.dart';
import '../utils/dependecies.dart';

class CityCard extends StatelessWidget {
  final String countryCode;
  final String country;
  final String place;
  final double lat;
  final double lon;
  const CityCard(
      {super.key,
      required this.countryCode,
      required this.place,
      required this.country,
      required this.lat,
      required this.lon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        onTap: () {
          debugPrint('dvdfv');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Home(
                        title: place,
                        latitude: lat,
                        longitude: lon,
                      )));
        },
        child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Flag.fromString(
                  countryCode,
                  width: 30,
                  height: 30,
                  borderRadius: 15,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: Text('$place, $country',
                        overflow: TextOverflow.ellipsis, maxLines: 1)),
                const Spacer(),
                Text('${lat ~/ 1}° E'),
                const SizedBox(width: 10),
                Text('${lon ~/ 1}° N')
              ],
            )));
  }
}
