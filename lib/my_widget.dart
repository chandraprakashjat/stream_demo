import 'package:flutter/material.dart';

import 'util/number_creator.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Operation'),
      ),
      body: StreamBuilder(
        stream: NumberController().stream.map((event) => 'Item $event'),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return const Center(
              child: Text('Done'),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error '),
            );
          } else {
            return Center(
              child: Text('${snapshot.data}'),
            );
          }
        }),
      ),
    );
  }

  void _doOperation() {
    var stream = NumberController()
        .stream
        .where((event) => (event % 2 == 0))
        .map((event) => 'Valdue $event');

    stream.listen((event) => print(event),
        onDone: () => print('done'),
        onError: (error, stack) => print(stack),
        cancelOnError: true);
  }
}
