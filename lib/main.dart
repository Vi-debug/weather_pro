import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:weather_pro/model/air.dart';
import 'package:weather_pro/model/day_forecast.dart';
import 'package:weather_pro/model/near_time_data.dart';
import 'package:weather_pro/model/other_info.dart';
import 'package:weather_pro/model/weather.dart';

import 'route_generator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.red, // navigation bar color
      statusBarColor: Colors.red, // status bar color
    ));
    return MaterialApp(
      title: 'Weather Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Opens-Sans',
        textTheme: TextTheme(
          headline4: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
          headline3: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
          headline2: const TextStyle(
            shadows: [
              const Shadow(
                blurRadius: 1.0,
                offset: Offset(1.0, 1.0),
              )
            ],
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          headline1: const TextStyle(
              fontFamily: 'Comfortaa',
              shadows: [
                const Shadow(
                  blurRadius: 1.0,
                  offset: Offset(1.0, 1.0),
                )
              ],
              fontSize: 150,
              fontWeight: FontWeight.w500,
              color: const Color.fromRGBO(255, 255, 255, 0.85)),
        ),
      ),
      initialRoute: '/main_screen',
      onGenerateRoute: RouteGenerator.generate,
    );
  }
}

Future<Weather> getWeather() async {
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
  return weather;
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
    final timeStamp = dataNextDay['daily'][i]['dt'];
    final date =
        DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000).toLocal();
    print('${date.day}/${date.month}');
    final day = DayForecast(
      avgTemperature: dataNextDay['daily'][i]['temp']['day'].round(),
      description: dataNextDay['daily'][i]['weather'][0]['description'],
      img: _getWeatherImageByID(dataNextDay['daily'][i]['weather'][0]['icon']),
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
      img: _getWeatherImageByID(dataNextDay['hourly'][i]['weather'][0]['icon']),
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
