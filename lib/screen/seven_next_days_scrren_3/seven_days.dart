import 'package:flutter/material.dart';
import 'package:weather_pro/model/day_forecast.dart';
import 'package:weather_pro/screen/seven_next_days_scrren_3/seven_day_widget.dart';

class SevenNextDays extends StatelessWidget {
  final List<DayForecast> listFollowingDays;

  const SevenNextDays({Key key, this.listFollowingDays}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: const Text(
              'Dự báo 7 ngày tới',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Expanded(
            child: SevenDaysWidget(listFollowingDays),
          ),
        ],
      ),
    );
  }
}
