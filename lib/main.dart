import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:snakes/screens/tabuleiro.dart';

import 'controllers/controller.dart';

void main() {
  GetIt getIt = GetIt.I;
  getIt.registerSingleton<CobrasEscadas>(CobrasEscadas());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Snakes & Ladders',
      home: Tabuleiro(),
    );
  }
}
