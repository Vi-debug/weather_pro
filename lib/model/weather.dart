import 'package:weather_pro/model/day_forecast.dart';
import 'package:weather_pro/model/near_time_data.dart';

import 'air.dart';

class Weather {
  final String locaiton;
  final int temperature;
  final Air air;
  final String description;
  final List<DayForecast> followingDays;
  final List<NearTimeData> listNearTimesData;
  final String sunRiseTime;
  final String sunSetTime;

  Weather({this.sunRiseTime, this.sunSetTime, 
      this.listNearTimesData,
      this.followingDays,
      this.description,
      this.locaiton,
      this.temperature,
      this.air});
}
