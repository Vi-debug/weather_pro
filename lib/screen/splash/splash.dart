import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:weather_pro/icons/weather_icon_icons.dart';
import 'package:weather_pro/model/air.dart';
import 'package:weather_pro/model/day_forecast.dart';
import 'package:weather_pro/model/near_time_data.dart';
import 'package:weather_pro/model/weather.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getWeather(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: null,
      body: Container(
        alignment: Alignment.center,
        color: Color.fromRGBO(44, 42, 54, 1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Weather',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w500,
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                Text(
                  ' PRO',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Image.asset('assets/weather.gif'),
            Text(
              'a product of Art',
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  void getWeather(BuildContext context) async {
    // //todo: get user location
    final apiKey = 'dfead8a8da2f58d80d6871874dcc7b94';
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }
    var currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double latitude = currentPosition.latitude;
    double longitude = currentPosition.longitude;
    var urlTemp =
        "http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&lang=vi&appid=$apiKey";

    var urlAir =
        "http://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude&lon=$longitude&appid=$apiKey";
    var urlNextDays =
        "http://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&units=metric&lang=vi&appid=$apiKey";
    // try {
    print(latitude);
    print(longitude);
    var responseTemp = await get(urlTemp);
    var responseAir = await get(urlAir);
    var responseNextDay = await get(urlNextDays);

    Map<String, dynamic> dataTemp = json.decode(responseTemp.body);
    Map<String, dynamic> dataAir = json.decode(responseAir.body);
    Map<String, dynamic> dataNextDay = json.decode(responseNextDay.body);
    var air = Air(
      nH3: dataAir['list'][0]['components']['nh3'],
      cO: dataAir['list'][0]['components']['co'],
      nO2: dataAir['list'][0]['components']['no2'],
      o3: dataAir['list'][0]['components']['o3'],
      sO2: dataAir['list'][0]['components']['so2'],
      pm2_5: dataAir['list'][0]['components']['pm2_5'],
      pm10: dataAir['list'][0]['components']['pm10'],
      overall: dataAir['list'][0]['main']['aqi'],
    );

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final theNext2Day = DateTime(now.year, now.month, now.day + 2);
    final theNext3Day = DateTime(now.year, now.month, now.day + 3);
    final listDateTime = [today, tomorrow, theNext2Day, theNext3Day];

    List<DayForecast> followingsDays =
        getTempFollowingDays(dataNextDay, listDateTime);
    List<NearTimeData> listNearTimeData = _getNearTimeData(dataNextDay);

    // get sun raise time and set time
    var dateRise =
        DateTime.fromMillisecondsSinceEpoch(dataTemp['sys']['sunrise'] * 1000)
            .toLocal();
    var dateSet =
        DateTime.fromMillisecondsSinceEpoch(dataTemp['sys']['sunset'] * 1000)
            .toLocal();

    var weather = Weather(
      locaiton: dataTemp['name'],
      temperature: dataTemp['main']['temp'].round(),
      description: dataTemp['weather'][0]['description'],
      air: air,
      followingDays: followingsDays,
      listDate: listDateTime,
      listNearTimesData: listNearTimeData,
      sunRiseTime: '${dateRise.hour}:${dateRise.minute}',
      sunSetTime: '${dateSet.hour}:${dateSet.minute}',
    );

    Navigator.pushNamed(context, '/main_screen', arguments: weather);
    // } catch (e) {
    //   showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         content: Text('Error $e'),
    //         title: Text('Error'),
    //         actions: [
    //           FlatButton(
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //             child: Text('Close'),
    //           )
    //         ],
    //       );
    //     },
    //   );
    // }
  }

  List<DayForecast> getTempFollowingDays(
      Map<String, dynamic> dataNextDay, List<DateTime> listDateTime) {
    var listDays = List<DayForecast>();
    List<dynamic> listData = dataNextDay['list'];
    var i = 1;
    int times = 0;
    while (i < listData.length) {
      dynamic data = listData[i];
      String hour = data['dt_txt'].split(' ')[1];
      if (hour == '00:00:00') {
        int idWeather1, idWeather2;
        String description;
        int totalTemp = data['main']['temp'].round();
        int minTemp = data['main']['temp_min'].round();
        do {
          data = listData[++i];
          hour = data['dt_txt'].split(' ')[1];
          totalTemp += data['main']['temp'].round();
          if (data['main']['temp_min'].round() < minTemp) {
            minTemp = data['main']['temp_min'].round();
          }
          if (hour == '09:00:00') {
            description = data['weather'][0]['description'];
            idWeather1 = data['weather'][0]['id'];
          }
          if (hour == '03:00:00') {
            idWeather2 = data['weather'][0]['id'];
          }
        } while (hour != '21:00:00');
        int avgTemp = (totalTemp / 8).round();
        var newDay = DayForecast(
            avgTemperature: avgTemp,
            minTemperature: minTemp,
            description: description,
            img: _getIconWeather(idWeather1, idWeather2),
            weekday: listDateTime[times + 1].weekday);
        listDays.add(newDay);
        if (++times == 3) break;
      }
      i++;
    }
    return listDays;
  }

  _getIconWeather(int idWeather1, int idWeather2) {
    if ((200 <= idWeather1 && idWeather1 <= 232) ||
        (200 <= idWeather2 && idWeather2 <= 232)) {
      return Image.asset('assets/weather_icon/cloud_thunder.png',
          width: 34, height: 34);
    }
    if (idWeather1 == 500 ||
        idWeather1 == 501 ||
        idWeather2 == 500 ||
        idWeather2 == 501) {
      return Image.asset('assets/weather_icon/small_rain_day.png',
          width: 34, height: 34);
    }
    if (idWeather1 == 502 ||
        idWeather1 == 503 ||
        idWeather1 == 504 ||
        idWeather2 == 504 ||
        idWeather2 == 502 ||
        idWeather2 == 503) {
      return Image.asset('assets/weather_icon/sun_cloud_heavy_rain.png',
          width: 34, height: 34);
    }

    if (idWeather1 == 520 ||
        idWeather1 == 521 ||
        idWeather1 == 522 ||
        idWeather1 == 531 ||
        idWeather2 == 520 ||
        idWeather2 == 521 ||
        idWeather2 == 522 ||
        idWeather2 == 531) {
      return Image.asset('assets/weather_icon/cloud_heavy_rain.png',
          width: 34, height: 34);
    }
    if (idWeather1 == 800)
      return Image.asset('assets/weather_icon/sunny.png',
          width: 34, height: 34);
    if (idWeather1 == 801 ||
        idWeather1 == 802 ||
        idWeather2 == 801 ||
        idWeather2 == 802) {
      return Image.asset('assets/weather_icon/sun_cloud.png',
          width: 34, height: 34);
    }
    if (idWeather1 == 803 ||
        idWeather1 == 804 ||
        idWeather2 == 803 ||
        idWeather2 == 804) {
      return Image.asset('assets/weather_icon/cloud.png',
          width: 34, height: 34);
    }
    if (idWeather1 == 741)
      return Image.asset('assets/weather_icon/fog.png', width: 34, height: 34);
    if ((600 <= idWeather1 && idWeather1 <= 622) ||
        (600 <= idWeather2 && idWeather2 <= 622)) {
      return Image.asset('assets/weather_icon/cloud_snow.png',
          width: 34, height: 34);
    }
    if ((300 <= idWeather1 && idWeather1 <= 321) ||
        (300 <= idWeather2 && idWeather2 <= 321)) {
      return Image.asset('assets/weather_icon/cloud_small_rain.png',
          width: 34, height: 34);
    }
    if ((701 <= idWeather1 && idWeather1 <= 781) ||
        (701 <= idWeather2 && idWeather2 <= 781)) {
      return Image.asset('assets/weather_icon/dust.png', width: 34, height: 34);
    }
    return Image.asset('assets/weather_icon/sun_cloud.png',
        width: 34, height: 34);
  }

  List<NearTimeData> _getNearTimeData(Map<String, dynamic> dataNextDay) {
    List<NearTimeData> listNearTimeData = List<NearTimeData>();
    var listData = dataNextDay['list'];
    for (var i = 0; i < 8; i++) {
      var dataNearTime = listData[i];
      String time = dataNearTime['dt_txt'].split(' ')[1].substring(0, 5);
      int temp = dataNearTime['main']['temp'].round();
      double windSpeed = dataNearTime['wind']['speed'];
      Image img = _getWeatherImageByID(dataNearTime['weather'][0]['id']);
      var nearTimeData = NearTimeData(
        time: time,
        temp: temp,
        windSpeed: windSpeed,
        img: img,
      );
      listNearTimeData.add(nearTimeData);
    }
    return listNearTimeData;
  }

  Image _getWeatherImageByID(int idWeather1) {
    if ((200 <= idWeather1 && idWeather1 <= 232)) {
      return Image.asset('assets/weather_icon/cloud_thunder.png',
          width: 34, height: 34);
    }
    if (idWeather1 == 500 || idWeather1 == 501) {
      return Image.asset('assets/weather_icon/small_rain_day.png',
          width: 34, height: 34);
    }
    if (idWeather1 == 502 || idWeather1 == 503 || idWeather1 == 504) {
      return Image.asset('assets/weather_icon/sun_cloud_heavy_rain.png',
          width: 34, height: 34);
    }

    if (idWeather1 == 520 ||
        idWeather1 == 521 ||
        idWeather1 == 522 ||
        idWeather1 == 531) {
      return Image.asset('assets/weather_icon/cloud_heavy_rain.png',
          width: 34, height: 34);
    }
    if (idWeather1 == 800)
      return Image.asset('assets/weather_icon/sunny.png',
          width: 34, height: 34);
    if (idWeather1 == 801 || idWeather1 == 802) {
      return Image.asset('assets/weather_icon/sun_cloud.png',
          width: 34, height: 34);
    }
    if (idWeather1 == 803 || idWeather1 == 804) {
      return Image.asset('assets/weather_icon/cloud.png',
          width: 34, height: 34);
    }
    if (idWeather1 == 741)
      return Image.asset('assets/weather_icon/fog.png', width: 34, height: 34);
    if ((600 <= idWeather1 && idWeather1 <= 622)) {
      return Image.asset('assets/weather_icon/cloud_snow.png',
          width: 34, height: 34);
    }
    if ((300 <= idWeather1 && idWeather1 <= 321)) {
      return Image.asset('assets/weather_icon/cloud_small_rain.png',
          width: 34, height: 34);
    }
    if ((701 <= idWeather1 && idWeather1 <= 781)) {
      return Image.asset('assets/weather_icon/dust.png', width: 34, height: 34);
    }
    return Image.asset('assets/weather_icon/sun_cloud.png',
        width: 34, height: 34);
  }
}
