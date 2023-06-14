import 'package:flutter/material.dart';
import 'package:weather/providers/providers.dart';
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
          context.read<HomeProvider>().setCurrentDay(0);
        },
        onLongPress: () {
          bool isSaved = false;
          LocalStorage.contains('PlaceSaved',
                  latitude: data['latitude'], longitude: data['longitude'])
              .then((value) => isSaved = value);
          showDialog<String>(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
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
                      ListTile(
                        title: Text(isSaved ? 'Unsave' : 'Save'),
                        trailing: IconButton(
                            onPressed: () {
                              if (isSaved) {
                                // Elimina il posto dai preferiti
                                LocalStorage.getIdFromCoordinates('PlaceSaved',
                                        latitude: data['latitude'],
                                        longitude: data['longitude'])
                                    .then((value) => LocalStorage.delete(
                                        table: 'PlaceSaved', id: value));
                              } else {
                                // Aggiungi il posto ai preferiti
                                LocalStorage.insertData('PlaceSaved',
                                    place: data['place'],
                                    country: data['country'],
                                    longitude: data['longitude'],
                                    latitude: data['latitude'],
                                    once: true);
                              }
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                duration: const Duration(seconds: 2),
                                content: Text(
                                    '${data['place']} has been ${isSaved ? 'removed' : 'added'} from your favourites'),
                                behavior: SnackBarBehavior.floating,
                              ));
                            },
                            icon: Icon(
                                isSaved
                                    ? FontAwesomeIcons.solidStar
                                    : FontAwesomeIcons.star,
                                size: 15)),
                      ),
                      const Divider(),
                      ListTile(
                        title: const Text('Delete'),
                        trailing: IconButton(
                            onPressed: () {
                              LocalStorage.delete(
                                  table: 'Recently', id: data['id']);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                duration: const Duration(seconds: 2),
                                content: Text('${data['place']} is eliminated'),
                                behavior: SnackBarBehavior.floating,
                              ));
                              weather.setRecentlyPlaces(notify: true);
                            },
                            icon: const Icon(FontAwesomeIcons.trash, size: 15)),
                      ),
                      const Divider(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              });
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
