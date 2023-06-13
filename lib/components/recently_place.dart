import 'package:flutter/material.dart';
import 'package:weather/providers/init.dart';
import 'package:weather/providers/local_storage.dart';
import 'package:weather/utils/dependencies.dart';

class RecentlyCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const RecentlyCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherProvider>();
    return InkWell(
      radius: 10,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      onTap: () {
        // Aggiorno i dati per la home
        weather.setData(
            ti: data['place'],
            cCode: data['country'],
            lat: data['latitude'],
            lon: data['longitude']);
        LocalStorage.updateDate('Recently', data['id']);
        weather.setIndex(0); // cambio pagina
      },
      onLongPress: () {
        LocalStorage.delete(table: 'Recently', id: data['id'] as int);
        weather.setRecentlyPlaces(notify: true);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Image.asset(
                      'icons/flags/png/${data['country'].trim().toLowerCase()}.png',
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                      package: 'country_icons')),
              const SizedBox(width: 5),
              Text(data['place']),
            ],
          ),
        ),
      ),
    );
  }
}
