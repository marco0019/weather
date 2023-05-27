import 'package:flutter/material.dart';
import 'package:weather/components/city_card.dart';
import 'package:weather/providers/init.dart';
import 'package:weather/utils/dependecies.dart';

class ListExample extends StatefulWidget {
  const ListExample({Key? key}) : super(key: key);

  @override
  State<ListExample> createState() => _ListExampleState();
}

class _ListExampleState extends State<ListExample> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> cities = [];
  Future<List<dynamic>> setList(
      {required WeatherProvider wp, required String city}) async {
    final result = await wp.fetchMapsOff(city);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final map = context.read<WeatherProvider>();
    return Scaffold(
        appBar: AppBar(title: const Text('Prova Custom TabBar')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: ListView(
              children: [
                TextFormField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Enter a city or any place...',
                    labelText: 'City',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red, // Cambia il colore del bordo
                          width: 2.0, // Cambia lo spessore del bordo
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    contentPadding: EdgeInsets.all(15),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Il campo non può essere vuoto';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  child: const Text('Invia'),
                  onPressed: () {
                    setList(wp: map, city: _controller.text)
                        .then((value) => setState(() => cities = value));
                  },
                ),
                for (Map<String, dynamic> city in cities)
                  CityCard(
                    countryCode: city['address']['country_code'],
                    place: city['address']['name'],
                    country: city['address']['country'],
                    lat: double.parse(city['lat']),
                    lon: double.parse(city['lon'])
                  )
              ],
            ),
          ),
        ));
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