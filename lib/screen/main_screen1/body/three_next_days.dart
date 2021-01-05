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
      margin:const EdgeInsets.symmetric(horizontal: 15),
      padding:const  EdgeInsets.all(10),
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
          Container(
            padding:const  EdgeInsets.all(7),
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: Text(
                'Xem thời tiết 7 ngày tới',
                style: const TextStyle(
                  fontSize: 13,
                  color:const Color.fromRGBO(255, 255, 255, 0.9),
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/seven_days_screen', arguments: followingDays);
              },
            ),
          ),
        ],
      ),
    );
  }
}
