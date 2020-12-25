import 'package:flutter/material.dart';
import 'package:weather_pro/model/weather.dart';
import 'package:weather_pro/screen/main_screen1/body/body_section.dart';

import 'appbar/custom_appbar.dart';

class MainInfo extends StatelessWidget {
  final Weather weather;

  const MainInfo({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: CustomAppBar(
              city: weather.locaiton,
            ),
          ),
          Expanded(
            flex: 7,
            child: BodyMainSection(
              weather: weather,
            ),
          ),
        ],
      ),
    );
  }
}
