import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          headline4: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
          headline3: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
          headline2:const  TextStyle(
            shadows: [
              const Shadow(
                blurRadius: 1.0,
                offset: Offset(1.0, 1.0),
              )
            ],
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          headline1:const TextStyle(
            fontFamily: 'Comfortaa',
            shadows: [
              const Shadow(
                blurRadius: 1.0,
                offset: Offset(1.0, 1.0),
              )
            ],
            fontSize: 150,
            fontWeight: FontWeight.w500,
            color:const Color.fromRGBO(255, 255, 255, 0.85)
          ),
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generate,
    );
  }
}

