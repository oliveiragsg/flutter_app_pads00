import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'screen0_home.dart';
import 'screen1_piano.dart';
import 'screen2_xylophone.dart';
import 'startScreen.dart';
import 'loginScreen.dart';
import 'signupScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => startScreen(),
        '/signup': (context) => signupScreen(),
        '/login': (context) => loginScreen(),
        '/home': (context) => Screen0(),
        '/piano': (context) => Screen1(),
        '/xylophone': (context) => Screen2(),

      }
    );
  }

}

