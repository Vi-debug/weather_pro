import 'package:flutter/material.dart';
import 'package:weather_pro/model/weather.dart';
import 'package:weather_pro/screen/main_screen1/body/sun_time.dart';

class OtherInfoSection extends StatelessWidget {
  final Weather weather;

  const OtherInfoSection({Key key, this.weather}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const  EdgeInsets.all(15),
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: SunTime(weather.sunRiseTime, weather.sunSetTime),
          ),
          Expanded(
            flex: 3,
            child: GridView.count(
              physics:const NeverScrollableScrollPhysics(),
              padding:const EdgeInsets.all(10),
              mainAxisSpacing: 10,
              childAspectRatio: 3,
              crossAxisCount: 2,
              children: [
                AdditionalInfo(
                  info: "Cảm giác như",
                  value: weather.otherInfo.fellLikeTemp.toString() + '\u00B0',
                ),
                AdditionalInfo(
                  info: "Độ ẩm",
                  value: weather.otherInfo.humidity.toString() + '%',
                ),
                AdditionalInfo(
                  info: "Chỉ số UV",
                  value: weather.otherInfo.uV,
                ),
                AdditionalInfo(
                  info: "Tầm nhìn",
                  value: (weather.otherInfo.visibility / 1000).toStringAsFixed(1) + ' km',
                ),
                AdditionalInfo(
                  info: "Tốc độ gió",
                  value: (weather.otherInfo.windSpeed * 3600 / 1000).toStringAsFixed(1) + ' km/h',
                ),
                AdditionalInfo(
                  info: "Hướng gió",
                  value: weather.otherInfo.windDirection,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AdditionalInfo extends StatelessWidget {
  final String info;
  final dynamic value;

  const AdditionalInfo({Key key, this.info, this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          info,
          style: const TextStyle(color: Color.fromRGBO(255,255,255,0.85), fontSize: 15),
        ),
        Text(
          value.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
