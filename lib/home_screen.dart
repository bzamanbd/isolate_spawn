// ignore_for_file: avoid_print

import 'dart:isolate';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 30),
          FilledButton(
            // onPressed: () => useIsolate(),
            onPressed: () => runHeavyTaskWithoutIsolate(900000000),
            child: const Text('Click me'),
          ),
        ],
      )),
    );
  }
}

int runHeavyTaskWithoutIsolate(int count) {
  int value = 0;
  for (var i = 0; i < count; i++) {
    value += i;
  }
  print('Result withOutIsolate: $value');
  return value;
}

Future useIsolate() async {
  final ReceivePort receivePort = ReceivePort();
  try {
    await Isolate.spawn(
        runHeavyTaskWithIsolate, [receivePort.sendPort, 900000000]);
  } on Object {
    print('isolate failed');
    receivePort.cast();
  }
  final response = await receivePort.first;
  print('Result withIsolate: $response');
}

int runHeavyTaskWithIsolate(List<dynamic> args) {
  SendPort resultPort = args[0];
  int value = 0;
  for (var i = 0; i < args[1]; i++) {
    value += 1;
  }
  Isolate.exit(resultPort, value);
}
