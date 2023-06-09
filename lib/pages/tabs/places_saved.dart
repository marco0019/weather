import 'package:flutter/material.dart';
import 'package:weather/components/components.dart';
import 'package:weather/providers/providers.dart';

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
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Saved',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: FutureBuilder(
        future: widget.wp.savedPlaces,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                  child: RandomLoading(
                      title: "Favourites",
                      description: "You don't have any favorites yet",
                      min: 6));
            }
            return Column(children: [
              for (Map<String, dynamic> place in snapshot.data!)
                PlaceSavedCard(data: place)
            ]);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const RandomLoading(
                      title: "Loading",
                      description: "Please, wait a moment...",
                      min: 6);
        },
      ),
    );
  }
}
