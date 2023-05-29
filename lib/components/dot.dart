import 'package:flutter/cupertino.dart';

class Dot extends StatelessWidget {
  final double size;
  final Color color;

  const Dot({super.key, required this.size, required this.color});

  @override
  Widget build(BuildContext context) => ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(size)),
      child: Container(width: size, height: size, color: color));
}
