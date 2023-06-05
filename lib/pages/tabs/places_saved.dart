import 'package:flutter/material.dart';
import 'package:weather/components/saved_place_card.dart';
import 'package:weather/providers/init.dart';
import 'package:weather/providers/local_storage.dart';

class PlacesSaved extends StatefulWidget {
  final WeatherProvider wp;

  const PlacesSaved({super.key, required this.wp});

  @override
  State<PlacesSaved> createState() => _PlacesSavedState();
}

class _PlacesSavedState extends State<PlacesSaved> {
  @override
  void initState() {
    super.initState();
    widget.wp.setSavedPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: widget.wp.savedPlaces,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(children: [
                for (Map<String, dynamic> place in snapshot.data!)
                  PlaceSavedCard(data: place)
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
