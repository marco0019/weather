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
    return Card(
      child: InkWell(
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
          /*ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            content: const Text('prova'),
            action: SnackBarAction(label: 'Retry', onPressed: () {}),
          ));*/
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    data['place'],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  const Divider(),
                  //const SizedBox(height: 10),
                  Row(children: [
                    const SizedBox(width: 10),
                    const Text('Save'),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(FontAwesomeIcons.solidStar, size: 15))
                  ]),
                  const Divider(),
                  Row(children: [
                    const SizedBox(width: 10),
                    const Text('Delete'),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(FontAwesomeIcons.trash, size: 15))
                  ]),
                  const Divider(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
          );
          //LocalStorage.delete(table: 'Recently', id: data['id'] as int);
          //weather.setRecentlyPlaces(notify: true);
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Image.asset(
                      'icons/flags/png/${(data['country'] as String).trim().toLowerCase()}.png',
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
