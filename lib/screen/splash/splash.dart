import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:weather_pro/icons/weather_icon_icons.dart';
import 'package:weather_pro/model/air.dart';
import 'package:weather_pro/model/day_forecast.dart';
import 'package:weather_pro/model/near_time_data.dart';
import 'package:weather_pro/model/other_info.dart';
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
    const APIKEY = 'dfead8a8da2f58d80d6871874dcc7b94'; 
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
        "http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&lang=vi&appid=$APIKEY";

    var urlAir =
        "http://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude&lon=$longitude&appid=$APIKEY";
    var urlNextDays =
        "https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&units=metric&lang=vi&appid=$APIKEY";
    // try {
    var responseTemp = await get(urlTemp);
    var responseAir = await get(urlAir);
    var responseNextDay = await get(urlNextDays);
    print(urlNextDays);
    Map<String, dynamic> dataTemp = json.decode(responseTemp.body);
    Map<String, dynamic> dataAir = json.decode(responseAir.body);
    Map<String, dynamic> dataNextDay = json.decode(responseNextDay.body);

    var air = _getAir(dataAir);
    var otherInfo = _getOtherInfo(dataNextDay);

    List<DayForecast> followingsDays = _getTempFollowingDays(dataNextDay);
    List<NearTimeData> listNearTimeData = _getTempFlowingHour(dataNextDay);

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
      listNearTimesData: listNearTimeData,
      sunRiseTime: '${dateRise.hour}:${dateRise.minute}',
      sunSetTime: '${dateSet.hour}:${dateSet.minute}',
      otherInfo: otherInfo,
    );

    Navigator.pushReplacementNamed(context, '/main_screen', arguments: weather);
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

  List<DayForecast> _getTempFollowingDays(Map<String, dynamic> dataNextDay) {
    var listDays = List<DayForecast>();
    final numberReportDay = 7;
    for (var i = 0; i < numberReportDay; i++) {
      final day = DayForecast(
        avgTemperature: dataNextDay['daily'][i]['temp']['day'].round(),
        description: dataNextDay['daily'][i]['weather'][0]['description'],
        img:
            _getWeatherImageByID(dataNextDay['daily'][i]['weather'][0]['icon']),
        minTemperature: dataNextDay['daily'][i]['temp']['night'].round(),
        weekday: _getWeekDayByTimeStamp(dataNextDay['daily'][i]['dt']),
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
    return Image.asset('assets/weather_icon/$iconName.png', width: 32, height: 32,);
  }

  int _getWeekDayByTimeStamp(int timeStamp) {
    final date =
        DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000).toLocal();
    return date.weekday;
  }

  String _getHourByTimeStamp(int timeStamp) {
    return DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000)
            .toLocal()
            .hour
            .toString() +
        ":00";
  }

  Air _getAir(Map<String, dynamic> dataAir) {
    return Air(
      nH3: dataAir['list'][0]['components']['nh3'],
      cO: dataAir['list'][0]['components']['co'],
      nO2: dataAir['list'][0]['components']['no2'],
      o3: dataAir['list'][0]['components']['o3'],
      sO2: dataAir['list'][0]['components']['so2'],
      pm2_5: dataAir['list'][0]['components']['pm2_5'],
      pm10: dataAir['list'][0]['components']['pm10'],
      overall: dataAir['list'][0]['main']['aqi'],
    );
  }

  OtherInfo _getOtherInfo(Map<String, dynamic> dataNextDay) {
    return OtherInfo(
      fellLikeTemp: dataNextDay['current']['feels_like'].round(),
      humidity: dataNextDay['current']['humidity'],
      windDirection: dataNextDay['current']['wind_deg'],
      uV: dataNextDay['current']['uvi'],
      visibility: dataNextDay['current']['visibility'],
      windSpeed: dataNextDay['current']['wind_speed'],
    );
  }
}
