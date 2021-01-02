import 'package:flutter/material.dart';
import 'package:weather_pro/model/weather.dart';
import 'package:weather_pro/screen/main_screen1/body/near_time_data.dart';
import 'package:weather_pro/screen/main_screen1/body/three_next_days.dart';
import 'package:weather_pro/screen/main_screen1/body/other_info_section.dart';

import 'temperature_section.dart';

class BodyMainSection extends StatelessWidget {
  final Weather weather;

  const BodyMainSection({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            TemperatureSection(
              currentTemperature: weather.temperature.toString(),
              description: weather.description,
              air: weather.air,
            ),
            NearTimeSection(weather.listNearTimesData),
            ThreeNextDays(followingDays: weather.followingDays),
            OtherInfoSection(weather: weather),
          ],
        ),
      ),
    );
  }

  
}
