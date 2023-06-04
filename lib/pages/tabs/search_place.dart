import 'package:flutter/material.dart';
import 'package:weather/components/init.dart';
import 'package:weather/components/recently_place.dart';
import 'package:weather/providers/init.dart';
import 'package:weather/providers/local_storage.dart';
import 'package:weather/utils/dependencies.dart';

final class SearchPlace extends StatefulWidget {
  final WeatherProvider wp;

  const SearchPlace({super.key, required this.wp});

  @override
  State<SearchPlace> createState() => _SearchPlaceState();
}

class _SearchPlaceState extends State<SearchPlace> {
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic> cities = {};
  String error = '';
  bool? isLoading;

  Future<void> setList({required String city}) async {
    try {
      setState(() => isLoading = true);
      final result = await widget.wp.fetchMapsGeoCoding(city.trim());
      setState(() => cities = result);
      setState(() => isLoading = false);
    } on Exception catch (err) {
      debugPrint(err.toString());
      setState(() => error = err.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    /*_controller.addListener(() {
      if (_controller.text != '') setList(city: _controller.text);
    });*/
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverAppBar(
        leading: IconButton(
            onPressed: () => {}, icon: const Icon(FontAwesomeIcons.star)),
        centerTitle: true,
        pinned: true,
        expandedHeight: 200,
        flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            expandedTitleScale: 2,
            title: Text(
              'Search',
              style: TextStyle(color: Theme.of(context).primaryColorLight),
            )),
      ),
      SliverToBoxAdapter(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(children: [
              SizedBox(
                width: 250,
                child: TextFormField(
                  controller: _controller,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    hintText: 'Enter a city or any place...',
                    fillColor: Theme.of(context).primaryColor,
                    focusColor: Theme.of(context).primaryColor,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor)),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor)),
                    contentPadding: const EdgeInsets.all(15),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Il campo non può essere vuoto';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                  autofocus: true,
                  style: ButtonStyle(
                      //shape: MaterialStatePropertyAll(),
                      padding:
                          const MaterialStatePropertyAll(EdgeInsets.all(0)),
                      overlayColor: MaterialStatePropertyAll(
                          Theme.of(context).primaryColor.withOpacity(.1)),
                      shadowColor:
                          const MaterialStatePropertyAll(Colors.transparent),
                      foregroundColor: MaterialStatePropertyAll(
                          Theme.of(context).primaryColor)),
                  onPressed: () => _controller.text == ''
                      ? null
                      : setList(city: _controller.text),
                  child: const Icon(FontAwesomeIcons.paperPlane))
            ])),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
      SliverToBoxAdapter(
        child: FutureBuilder(
            future: LocalStorage.getItems('Recently'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                    //scrollDirection: Axis.horizontal,
                    children: [
                      for (final item in snapshot.data!)
                        RecentlyCard(data: item)
                    ]);
              } else if (snapshot.hasError) {
                return const Text('errpre');
              } else {
                return const Text('loading');
              }
            }),
      ),
      if (error != '')
        Text(error)
      else if (isLoading == null)
        const SliverToBoxAdapter(
          child: RandomLoading(
              title: 'Cerca un luogo...',
              description: 'Non hai ancora cercato nessuno luogo'),
        )
      else if (isLoading!)
        const SliverToBoxAdapter(
          child: RandomLoading(
            title: 'Caricamento...',
            description: 'Sto mandando la richiesta al server...',
          ),
        )
      else if (cities['results'] != null)
        for (Map<String, dynamic> city in cities['results'] as List<dynamic>)
          SliverToBoxAdapter(
            child: CityCard(
                timezone: city['timezone'],
                countryCode: city['country_code'],
                place: city['name'],
                country: city['country'] ?? ' ',
                lat: city['latitude'],
                lon: city['longitude']),
          )
      else
        const Center(child: Text('No results', style: TextStyle(fontSize: 30))),
      const SliverToBoxAdapter(child: SizedBox(height: 80))
    ]));
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
