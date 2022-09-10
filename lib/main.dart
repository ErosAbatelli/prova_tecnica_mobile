import 'package:flutter/material.dart';
import 'package:prova_tecnica_mobile/quesito1.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Quesito1(),
    );
  }
}
