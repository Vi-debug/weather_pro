import 'package:flutter/material.dart';
import 'package:weather_pro/model/air.dart';
import 'package:weather_pro/model/day_forecast.dart';
import 'package:weather_pro/model/weather.dart';
import 'package:weather_pro/screen/air_screen_2/air_screen_2.dart';
import 'package:weather_pro/screen/seven_next_days_scrren_3/seven_days.dart';

import 'screen/main_screen1/main_screen.dart';

class RouteGenerator {
  static Route<String> generate(RouteSettings settings) {
    final arg = settings.arguments;
    switch (settings.name) {
      case '/main_screen':
          return MaterialPageRoute(
            builder: (context) => MainScreen(),
          );
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
        'Some error happened',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
