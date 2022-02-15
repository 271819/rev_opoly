import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rev_opoly/loginscreen.dart';

// import 'loginscreen.dart';
 
 
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    
    Timer(
      Duration(seconds: 5),
      ()=>Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (content)=> LoginScreen())) );
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Image.asset('assets/images/revopoly.JPG',scale: 0.005)),
          ],)
        ),
      );
  }
}