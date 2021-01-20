import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:weather_pro/model/air.dart';
import 'package:weather_pro/model/api_weather.dart';
import 'package:weather_pro/model/day_forecast.dart';
import 'package:weather_pro/model/near_time_data.dart';
import 'package:weather_pro/model/other_info.dart';
import 'package:weather_pro/model/weather.dart';

class MainScreenViewModel with ChangeNotifier {
  Weather _weather;

  Weather get weather => _weather;

  MainScreenViewModel() {
    updateWeather();
  }
  updateWeather() async {
    _weather = await getWeather();
    notifyListeners();
  }

  Future<Weather> getWeather() async {
    Position pos = await _getUserPosition();
    var api = ApiWeather(pos.latitude, pos.longitude);
    var responseTemp = await get(api.getUrlTemp());
    var responseAir = await get(api.getUrlAir());
    var responseNextDay = await get(api.getUrlNextDay());

    var dataTemp = json.decode(responseTemp.body);
    var dataAir = json.decode(responseAir.body);
    var dataNextDay = json.decode(responseNextDay.body);

    var air = Air.fromJson(dataAir['list'][0]);
    var otherInfo = OtherInfo.fromJson(dataNextDay['current']);

    List<DayForecast> followingsDays = _getTempFollowingDays(dataNextDay);
    List<NearTimeData> listNearTimeData = _getTempFlowingHour(dataNextDay);

    // get sun raise time and set time
    var dateRise = _getTimeFromTimeStamp(dataTemp['sys']['sunrise']);
    var dateSet = _getTimeFromTimeStamp(dataTemp['sys']['sunset']);

    var weather = Weather(
      locaiton: dataTemp['name'],
      temperature: dataTemp['main']['temp'].round(),
      description: dataTemp['weather'][0]['description'],
      air: air,
      followingDays: followingsDays,
      listNearTimesData: listNearTimeData,
      sunRiseTime: '${dateRise.hour}:${dateRise.minute}',
      sunSetTime: '${dateSet.hour}:${dateSet.minute}',
      otherInfo: otherInfo,
    );
    return weather;
  }

  List<DayForecast> _getTempFollowingDays(Map<String, dynamic> dataNextDay) {
    var listDays = List<DayForecast>();
    final numberReportDay = 7;
    for (var i = 0; i < numberReportDay; i++) {
      final timeStamp = dataNextDay['daily'][i]['dt'];
      final date =
          DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000).toLocal();
      final day = DayForecast(
        avgTemperature: dataNextDay['daily'][i]['temp']['day'].round(),
        description: dataNextDay['daily'][i]['weather'][0]['description'],
        img:
            _getWeatherImageByID(dataNextDay['daily'][i]['weather'][0]['icon']),
        minTemperature: dataNextDay['daily'][i]['temp']['night'].round(),
        weekday: date.weekday,
        dayAndMonth: '${date.day} / ${date.month}',
      );
      listDays.add(day);
    }
    return listDays;
  }

  List<NearTimeData> _getTempFlowingHour(Map<String, dynamic> dataNextDay) {
    List<NearTimeData> listNearTimeData = List<NearTimeData>();
    final numberOfReportHour = 24;
    for (var i = 0; i < numberOfReportHour; i++) {
      listNearTimeData.add(NearTimeData(
        img: _getWeatherImageByID(
            dataNextDay['hourly'][i]['weather'][0]['icon']),
        temp: dataNextDay['hourly'][i]['temp'].round(),
        time: _getHourByTimeStamp(dataNextDay['hourly'][i]['dt']),
        windSpeed: dataNextDay['hourly'][i]['wind_speed'],
      ));
    }
    return listNearTimeData;
  }

  Image _getWeatherImageByID(String iconName) {
    return Image.asset(
      'assets/weather_icon/$iconName.png',
      width: 32,
      height: 32,
    );
  }

  String _getHourByTimeStamp(int timeStamp) {
    return DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000)
            .toLocal()
            .hour
            .toString() +
        ":00";
  }

  DateTime _getTimeFromTimeStamp(timeStamp) {
    return DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000).toLocal();
  }

  Future<Position> _getUserPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }
    var currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return currentPosition;
  }
}
