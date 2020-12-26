import 'package:flutter/material.dart';
import 'package:weather_pro/model/day_forecast.dart';

import 'day_widget.dart';

class ThreeNextDays extends StatelessWidget {
  final List<DayForecast> followingDays;

  const ThreeNextDays({Key key, this.followingDays}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.all(3),
      child: Column(
        children: [
          DayWidget(forecast: followingDays[0], isToday: true),
          DayWidget(
            forecast: followingDays[1],
            isTomorrow: true,
          ),
          DayWidget(
            forecast: followingDays[2],
          ),
        ],
      ),
    );
  }
}
