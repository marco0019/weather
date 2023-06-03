import 'package:flutter/material.dart';
import 'package:weather/providers/local_storage.dart';

class PlacesSaved extends StatefulWidget {
  const PlacesSaved({super.key});

  @override
  State<PlacesSaved> createState() => _PlacesSavedState();
}

class _PlacesSavedState extends State<PlacesSaved> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: LocalStorage.getItems('PlaceSaved'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(children: [
                for (Map<String, dynamic> place in snapshot.data!)
                  Text(place['place'] + place['latitude'].toString())
              ]);
            } else if (snapshot.hasError) {
              return const Text('errore');
            }
            return const Text('loading');
          },
        ),
      ),
    );
  }
}
