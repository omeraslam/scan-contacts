import 'package:flutter/material.dart';
import 'components/screens/on_boarding/on_boarding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnBoarding(),
    );
  }
}
