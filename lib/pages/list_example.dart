import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListExample extends StatefulWidget {
  const ListExample({Key? key}) : super(key: key);

  @override
  State<ListExample> createState() => _ListExampleState();
}

class _ListExampleState extends State<ListExample> {
  final PageController _controller = PageController();
  final List<String> titoli = [
    'prova1',
    'prova2',
    'prova3',
    'prova4',
    'prova5',
    'prova6'
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sized = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: const Text('Prova Custom TabBar')),
        body: Container(
          width: sized.width,
          height: sized.height,
          child: Column(
            children: [
              const Text('inizio lista'),
              PageView.builder(
                controller: _controller,
                pageSnapping: true,
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Text(
                  '$index',
                  style: const TextStyle(fontSize: 40, color: Colors.black),
                ),
              )
            ],
          ),
        ));
  }
}
