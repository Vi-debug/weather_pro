import 'package:flutter/material.dart';
import 'package:weather_pro/model/air.dart';
import 'package:weather_pro/model/day_forecast.dart';
import 'package:weather_pro/model/weather.dart';
import 'package:weather_pro/screen/air_screen_2/air_screen_2.dart';
import 'package:weather_pro/screen/seven_next_days_scrren_3/seven_days.dart';

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
        return MaterialPageRoute(
          builder: (context) => _ErrorRoute(),
        );
      case '/air_screen':
        if (arg is Air) {
          return MaterialPageRoute(
            builder: (context) => AirScreen(
              air: arg,
            ),
          );
        }
        return MaterialPageRoute(
          builder: (context) => _ErrorRoute(),
        );
      case '/seven_days_screen':
        if (arg is List<DayForecast>) {
          return MaterialPageRoute(
            builder: (context) => SevenNextDays(listFollowingDays: arg),
          );
        }
        return MaterialPageRoute(
          builder: (context) => _ErrorRoute(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => _ErrorRoute(),
        );
    }
  }
}

class _ErrorRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.red,
      child: const Text(
        'Some error has happened 3 times',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
