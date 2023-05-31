import 'package:flutter/material.dart';
import 'package:weather/providers/home_provider.dart';
import 'package:weather/utils/dependencies.dart';

class SingleChoice extends StatelessWidget {
  const SingleChoice({super.key});

  @override
  Widget build(BuildContext context) {
    final home = context.watch<HomeProvider>();
    return SegmentedButton<int>(
      style: const ButtonStyle(
          padding: MaterialStatePropertyAll(EdgeInsets.all(5)),
          animationDuration: Duration(milliseconds: 500),
          backgroundColor: MaterialStatePropertyAll(Colors.transparent)),
      segments: const <ButtonSegment<int>>[
        ButtonSegment<int>(value: 1, label: Text('1 hr')),
        ButtonSegment<int>(value: 2, label: Text('2 hr')),
        ButtonSegment<int>(value: 3, label: Text('3 hr')),
      ],
      selected: <int>{home.range},
      onSelectionChanged: (Set<int> newSelection) {
        home.range = newSelection.first;
      },
    );
  }
}
