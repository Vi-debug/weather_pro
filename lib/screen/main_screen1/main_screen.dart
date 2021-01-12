import 'package:flutter/material.dart';
import 'package:weather_pro/model/weather.dart';
import 'package:weather_pro/viewmodels/main_screen_view_model.dart';

import 'background.dart';
import 'info_section.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Weather weather;
  @override
  void initState() {
    var futureWeather = MainScreenViewModel().getWeather();
    futureWeather.then((value) {
      setState(() {
        weather = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(),
        Positioned.fill(child: Container(color: Colors.black12)),
        weather == null
            ? Positioned.fill(child: Center(child: CircularProgressIndicator()))
            : Positioned.fill(
                child: MainInfo(
                weather: weather,
              )),
      ],
    );
  }
}
