import 'package:flutter/material.dart';
import 'package:weather/components/init.dart';

final class HourlyList extends StatefulWidget {
  final Map<String, dynamic> value;
  final DateTime day;
  final int range;
  const HourlyList(
      {super.key, this.range = 1, required this.day, required this.value});

  @override
  State<HourlyList> createState() => _HourlyListState();
}

class _HourlyListState extends State<HourlyList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < (widget.value['time'] as List<dynamic>).length; i++)
          if (DateTime.parse(widget.value['time'][i]).year == widget.day.year &&
              DateTime.parse(widget.value['time'][i]).month ==
                  widget.day.month &&
              DateTime.parse(widget.value['time'][i]).day == widget.day.day)
            HourlyCard(
                hour: DateTime.parse(widget.value['time'][i]).hour,
                weathercode: widget.value['weathercode'][i] as int,
                temperature: widget.value['temperature_2m'][i] as double,
                windDirection: widget.value['winddirection_10m'][i] as int,
                windSpeed: widget.value['windspeed_10m'][i] as double,
                precipitationrobability:
                    widget.value['precipitation_probability'][i] as int,
                isDay: (widget.value['is_day'][i] as int) == 1,
                rain: widget.value['rain'][i] as double)
      ],
    );
  }
}
//pk.99377b1a33c03093ee4e776812215a80