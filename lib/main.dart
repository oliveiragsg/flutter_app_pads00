import 'package:flutter/material.dart';
import 'package:flutter_app_pads00/routes/app_routes.dart';
import 'screen0_home.dart';
import 'screen1_piano.dart';
import 'screen2_xylophone.dart';
import 'screen3_drum.dart';
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
        AppRoutes.START : (_) => startScreen(),
        AppRoutes.SIGNUP : (_) => signupScreen(),
        AppRoutes.LOGIN : (_) => loginScreen(),
        AppRoutes.HOME : (_) => Screen0(),
        AppRoutes.PIANO : (_) => Screen1(),
        AppRoutes.XYLOPHONE : (_) => Screen2(),
        AppRoutes.DRUM : (_) => Screen3(),
        // '/': (context) => startScreen(),
        // '/signup': (context) => signupScreen(),
        // '/login': (context) => loginScreen(),
        // '/home': (context) => Screen0(),
        // '/piano': (context) => Screen1(),
        // '/xylophone': (context) => Screen2(),
        // '/drum': (context) => Screen3(),

      }
    );
  }

}

