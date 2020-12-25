import 'package:flutter/widgets.dart';

class DayForecast {
  final int weekday;
  final String description;
  final int avgTemperature;
  final int minTemperature;
  final Image img;

  DayForecast(
      {this.weekday,
      this.description,
      this.avgTemperature,
      this.minTemperature,
      this.img});
}
