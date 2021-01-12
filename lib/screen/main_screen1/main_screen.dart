import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_pro/model/weather.dart';
import 'package:weather_pro/screen/main_screen1/info_section.dart';

import 'background.dart';

class MainScreen extends StatelessWidget {
  final Weather weather;
  const MainScreen({
    this.weather,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(),
        Positioned.fill(child: Container(color: Colors.black12)),
      //  Positioned.fill(child: MainInfo(weather: weather))
      ],
    );
  }
}
