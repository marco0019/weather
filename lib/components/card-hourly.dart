import 'package:flutter/material.dart';

class HourlyPage extends StatefulWidget {
  final String day;
  final Map<String, dynamic> data;
  const HourlyPage({super.key, required this.day, required this.data});

  @override
  State<HourlyPage> createState() => _HourlyPageState();
}

class _HourlyPageState extends State<HourlyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.day),
      ),
      body: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('sdfvsdvf'),
              SizedBox(width: 10),
              Text(
                'day',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text('min'),
              SizedBox(width: 10),
              Text('max'),
            ],
          ),
        ),
      ),
    );
  }
}
