import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather_pro/model/weather.dart';
import 'package:weather_pro/screen/main_screen1/body/near_time_data.dart';
import 'package:weather_pro/screen/main_screen1/body/three_next_days.dart';
import 'package:weather_pro/screen/main_screen1/body/other_info_section.dart';
import 'package:weather_pro/viewmodels/main_screen_view_model.dart';

import 'temperature_section.dart';
class BodyMainSection extends StatefulWidget {
  BodyMainSection({Key key}) : super(key: key);

  @override
  _BodyMainSectionState createState() => _BodyMainSectionState();
}

class _BodyMainSectionState extends State<BodyMainSection> {
  RefreshController refreshContoller;
  @override
  void initState() {
    super.initState();
    refreshContoller = RefreshController(initialRefresh: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenViewModel>(
      builder: (context, mainScreenVM, child) => SmartRefresher(
        controller: refreshContoller,
        enablePullDown: true,
        header: WaterDropHeader(),
        onRefresh: _updateWeather,
        child: mainScreenVM.weather == null
            ? Center(
              child: CircularProgressIndicator(),
            )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      TemperatureSection(
                        currentTemperature:
                            mainScreenVM.weather.temperature.toString(),
                        description: mainScreenVM.weather.description,
                        air: mainScreenVM.weather.air,
                      ),
                      NearTimeSection(mainScreenVM.weather.listNearTimesData),
                      ThreeNextDays(
                          followingDays: mainScreenVM.weather.followingDays),
                      OtherInfoSection(weather: mainScreenVM.weather),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void _updateWeather() {
    Provider.of<MainScreenViewModel>(context, listen: false).updateWeather();
    refreshContoller.refreshCompleted();
  }

  @override
  void dispose() {
    refreshContoller.dispose();
    super.dispose();
  }
}
