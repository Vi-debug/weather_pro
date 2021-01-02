import 'package:flutter/material.dart';
import 'package:weather_pro/model/air.dart';
import 'package:weather_pro/model/weather.dart';
import 'package:weather_pro/screen/air_screen_2/air_screen_2.dart';

import 'screen/main_screen1/main_screen.dart';
import 'screen/splash/splash.dart';

class RouteGenerator {
  static Route<String> generate(RouteSettings settings) {
    final arg = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
      case '/main_screen':
        if (arg is Weather) {
          return MaterialPageRoute(
            builder: (context) => MainScreen(
              weather: arg,
            ),
          );
        }
        return _errorRoute();
      case '/air_screen':
        if (arg is Air) {
          return MaterialPageRoute(
            builder: (context) => AirScreen(air: arg,),
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => Container(
        alignment: Alignment.center,
        color: Colors.red,
        child: Text(
          'Some error happened',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
