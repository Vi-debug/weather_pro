import 'package:flutter/material.dart';
import 'package:weather_pro/icons/custom_icon_icons.dart';
import 'package:weather_pro/model/air.dart';

class TemperatureSection extends StatelessWidget {
  final String currentTemperature;
  final String description;
  final Air air;

  const TemperatureSection(
      {Key key, @required this.currentTemperature, this.description, this.air})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentTemperature,
                style: Theme.of(context).textTheme.headline1,
              ),
              Text('\u2103', style: Theme.of(context).textTheme.headline2),
            ],
          ),
          Text(
            description,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              Expanded(child: Container()),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'air quality',
                        child: Icon(
                          CustomIcon.leaf,
                          size: 18,
                          color: Colors.green.shade700,
                        ),
                      ),
                      Text(
                        ' AQI ${air.getAirQualityText()}',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Open-Sans',
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/air_screen', arguments: air);
                },
              ),
              Expanded(child: Container()),
            ],
          )
        ],
      ),
    );
  }
}
