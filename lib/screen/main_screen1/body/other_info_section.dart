import 'package:flutter/material.dart';
import 'package:weather_pro/model/weather.dart';
import 'package:weather_pro/screen/main_screen1/body/sun_time.dart';

class OtherInfoSection extends StatelessWidget {
  final Weather weather;

  const OtherInfoSection({Key key, this.weather}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: SunTime(weather.sunRiseTime, weather.sunSetTime),
          ),
          Expanded(
            flex: 3,
            child: Container(),
          )
        ],
      ),
    );
  }
}
