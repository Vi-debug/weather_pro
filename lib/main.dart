import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:weather_pro/screen/main_screen1/main_screen.dart';
import 'package:weather_pro/screen/splash/splash.dart';

import 'route_generator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));
    return MaterialApp(
      title: 'Weather Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Opens-Sans',
        textTheme: TextTheme(
          headline4: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
          headline3: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
          headline2: TextStyle(
            shadows: [
              Shadow(
                blurRadius: 1.0,
                offset: Offset(1.0, 1.0),
              )
            ],
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          headline1: TextStyle(
            fontFamily: 'Comfortaa',
            shadows: [
              Shadow(
                blurRadius: 1.0,
                offset: Offset(1.0, 1.0),
              )
            ],
            fontSize: 150,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(255, 255, 255, 0.85)
          ),
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generate,
    );
  }
}

