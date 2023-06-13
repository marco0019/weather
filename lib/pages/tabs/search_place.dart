import 'package:flutter/material.dart';
import 'package:weather/components/init.dart';
import 'package:weather/components/recently_place.dart';
import 'package:weather/providers/init.dart';

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
    widget.wp.setRecentlyPlaces();
    _controller.addListener(() {
      if (_controller.text.length > 2) setList(city: _controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Search',
              style: TextStyle(fontSize: 30),
            )),
        body: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Padding(
                padding: const EdgeInsets.all(10),
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
                )),
          ),
          SliverToBoxAdapter(
            child: FutureBuilder(
                future: widget.wp.recentlyPlace,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      //color: Colors.green,
                      height: 50,
                      //width: 200,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (final item in snapshot.data!)
                              RecentlyCard(data: item)
                          ]),
                    );
                  } else if (snapshot.hasError) {
                    return const SizedBox();
                  } else {
                    return const SizedBox();
                  }
                }),
          ),
          const SliverToBoxAdapter(child: Divider()),
          if (error != '')
            Text(error)
          else if (isLoading == null)
            const SliverToBoxAdapter(
                child: RandomLoading(
                    title: 'Search a place...',
                    description: 'You haven\'t searched anywhere yet',
                    min: 6,
                    max: 7))
          else if (isLoading!)
            const SliverToBoxAdapter(
                child: RandomLoading(
                    title: 'Loading...', description: '', min: 6, max: 7))
          else if (cities['results'] != null)
            for (Map<String, dynamic> city
                in cities['results'] as List<dynamic>)
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
            const SliverToBoxAdapter(
              child: Center(
                  child: Text('No results', style: TextStyle(fontSize: 30))),
            ),
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
