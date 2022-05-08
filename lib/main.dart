import 'package:flutter/material.dart';
import 'package:rev_opoly/splashscreen.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'REV-OPOLY ON THE GO', 
      home: SplashScreen());
  }
}