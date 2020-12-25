import 'package:flutter/material.dart';
import 'package:weather_pro/icons/custom_icon_icons.dart';

class TemperatureSection extends StatelessWidget {
  final String currentTemperature;
  final String description;
  final String aQI;

  const TemperatureSection(
      {Key key, @required this.currentTemperature, this.description, this.aQI})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 70),
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
              ), //todo get data from accumweather
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
          GestureDetector(
            child: SizedBox(
              width: 200,
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CustomIcon.leaf,
                      size: 18,
                      color: Colors.green.shade700,
                    ),
                    Text(
                      ' AQI $aQI',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Open-Sans',
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ),
            onTap: () {
              // todo go to detail air quality screen
            },
          )
        ],
      ),
    );
  }
}
