import 'package:flutter/material.dart';
import 'package:weather_pro/model/day_forecast.dart';

class DayWidget extends StatelessWidget {
  final DayForecast forecast;
  final String day;
  final bool isTomorrow;
  final bool isToday;

  const DayWidget(
      {Key key, this.forecast, this.day, this.isTomorrow, this.isToday})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          forecast.img,
          CustomText(
            text: (isTomorrow == null || isTomorrow == false)
                ? ((isToday == null || isToday == false)
                    ? (forecast.weekday != 7
                        ? '  Thứ ${forecast.weekday + 1}'
                        : '  Chủ nhật')
                    : '  Hôm nay')
                : '  Ngày mai',
          ),
          Expanded(child: Container()),
          CustomText(text: '${forecast.avgTemperature} \u00B0'),
          CustomText(
            text: ' / ',
          ),
          CustomText(text: '${forecast.minTemperature} \u00B0'),
        ],
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;

  const CustomText({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Open-Sans',
        color: Colors.white,
        fontSize: 16,
      ),
    );
  }
}
