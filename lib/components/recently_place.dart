import 'package:flutter/cupertino.dart';

class RecentlyCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const RecentlyCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(data['place']);
  }
}
