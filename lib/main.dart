import 'package:flutter/material.dart';

import 'home_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'spawn',
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.purple,
    ),
    home: const HomeScreen(),
  ));
}
