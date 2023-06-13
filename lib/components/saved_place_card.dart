import 'package:flutter/material.dart';
import 'package:weather/providers/init.dart';
import 'package:weather/providers/local_storage.dart';
import 'package:weather/utils/dependencies.dart';

class PlaceSavedCard extends StatefulWidget {
  final Map<String, dynamic> data;
  const PlaceSavedCard({super.key, required this.data});
  @override
  State<PlaceSavedCard> createState() => _PlaceSavedCardState();
}

class _PlaceSavedCardState extends State<PlaceSavedCard> {
  bool isSaved = true;
  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherProvider>();
    return Card(
      child: InkWell(
        radius: 10,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        onTap: () {
          weather.setData(
              ti: widget.data['place'],
              cCode: widget.data['country'],
              lat: widget.data['latitude'],
              lon: widget.data['longitude']);
          weather.setIndex(0); // Cambia pagina
          // Aggiornare o aggiungere il posto tra i recenti
          LocalStorage.contains('Recently',
                  latitude: widget.data['latitude'],
                  longitude: widget.data['longitude'])
              .then((value) {
            if (value) {
              // Deve aggiornare i dati in base alla longitudine e alla latitudine
              LocalStorage.updateDateFromCoordinates('Recently',
                  latitude: widget.data['latitude'],
                  longitude: widget.data['longitude']);
            } else {
              // Deve inserire un nuovo elemento nei posti recenti
              LocalStorage.insertData('Recently',
                  place: widget.data['place'],
                  country: widget.data['country'],
                  longitude: widget.data['longitude'],
                  latitude: widget.data['latitude'],
                  once: true);
            }
          });
        },
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                child: Image.asset(
                    'icons/flags/png/${widget.data['country'].trim().toLowerCase()}.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    package: 'country_icons')),
          ),
          Text(widget.data['place'],
              style: const TextStyle(
                  fontSize: 20, overflow: TextOverflow.ellipsis)),
          const Spacer(),
          IconButton(
              onPressed: () {
                if (isSaved) {
                  LocalStorage.delete(
                      table: 'PlaceSaved', id: widget.data['id']);
                } else {
                  LocalStorage.insertData('PlaceSaved',
                      place: widget.data['place'],
                      country: widget.data['country'],
                      longitude: widget.data['longitude'],
                      latitude: widget.data['latitude'],
                      once: true);
                }
                setState(() {
                  isSaved = !isSaved;
                });
              },
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(isSaved
                    ? FontAwesomeIcons.solidStar
                    : FontAwesomeIcons.star),
              ))
        ]),
      ),
    );
  }
}
/*
const Spacer(),
          IconButton(
              onPressed: () {
                LocalStorage.delete(table: 'PlaceSaved', id: data['id']);
                weather.setSavedPlaces(notify: true);
              },
              icon: const Icon(FontAwesomeIcons.star)), */