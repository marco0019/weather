import 'package:flutter/material.dart';
import 'package:weather/components/init.dart';
import 'package:weather/providers/init.dart';
import 'package:weather/utils/dependencies.dart';

final class SearchPlace extends StatefulWidget {
  const SearchPlace({Key? key}) : super(key: key);

  @override
  State<SearchPlace> createState() => _SearchPlaceState();
}

class _SearchPlaceState extends State<SearchPlace> {
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic> cities = {};
  String error = '';
  bool? isLoading;

  Future<void> setList(
      {required WeatherProvider wp, required String city}) async {
    try {
      setState(() => isLoading = true);
      final result = await wp.fetchMapsGeoCoding(city.trim());
      setState(() => cities = result);
      setState(() => isLoading = false);
    } on Exception catch (err) {
      debugPrint(err.toString());
      setState(() => error = err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final map = context.read<WeatherProvider>();
    return Scaffold(
      //bottomNavigationBar: const BottomCustomBar(),
      appBar: AppBar(title: const Text('Search')),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: ListView(children: [
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter a city or any place...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0))),
                      contentPadding: EdgeInsets.all(15),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Il campo non può essere vuoto';
                      }
                      return null;
                    },
                  )),
              const SizedBox(height: 16.0),
              ElevatedButton(
                child: const Text('Invia'),
                onPressed: () => _controller.text == ''
                    ? null
                    : setList(wp: map, city: _controller.text),
              ),
              if (error != '')
                Text(error)
              else if (isLoading == null)
                const RandomLoading(
                    title: 'Cerca un luogo...',
                    description: 'Non hai ancora cercato nessuno luogo')
              else if (isLoading!)
                const RandomLoading(
                  title: 'Caricamento...',
                  description: 'Sto mandando la richiesta al server...',
                )
              else
                for (Map<String, dynamic> city
                    in cities['results'] as List<dynamic>)
                  CityCard(
                      timezone: city['timezone'],
                      countryCode: city['country_code'],
                      place: city['name'],
                      country: city['country'],
                      lat: city['latitude'],
                      lon: city['longitude'])
            ]),
          )),
    );
  }
}
/*
Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text == '') {
              return const Iterable.empty();
            }
            return ['prova1', 'aa', 'sdvsdfv', 'bfdgb'].where((String option) {
              return option.contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: (String selection) {
          },
        )
*/
