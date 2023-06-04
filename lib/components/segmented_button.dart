import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/providers/home_provider.dart';
import 'package:weather/providers/init.dart';
import 'package:weather/utils/dependencies.dart';

class SingleChoice extends StatelessWidget {
  const SingleChoice({super.key});

  @override
  Widget build(BuildContext context) {
    final home = context.watch<HomeProvider>();
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            onTap: () => home.range = 1,
            child: itemTextButton(context, '1hr', home.range == 1)),
        InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            onTap: () => home.range = 2,
            child: itemTextButton(context, '2hr', home.range == 2)),
        InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            onTap: () => home.range = 3,
            child: itemTextButton(context, '3hr', home.range == 3))
      ],
    );
  }

  Widget itemTextButton(
          BuildContext ctx, String label, bool isActive) =>
      Container(
          decoration: BoxDecoration(
              color: isActive ? Theme.of(ctx).primaryColor : null,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          padding: const EdgeInsets.all(10),
          child: Text(label));
}
