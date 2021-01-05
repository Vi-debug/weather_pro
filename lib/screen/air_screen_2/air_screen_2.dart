import 'package:flutter/material.dart';
import 'package:weather_pro/icons/custom_icon_icons.dart';
import 'package:weather_pro/model/air.dart';

class AirScreen extends StatelessWidget {
  final Air air;
  const AirScreen({Key key, this.air}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        height: size.height,
        padding:const  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                children: [
                  Hero(
                    transitionOnUserGestures: true,
                    tag: 'air quality',
                    child: Icon(
                      CustomIcon.leaf,
                      size: 24,
                      color: Colors.green.shade700,
                    ),
                  ),
                  const Text(
                    ' Chất lượng không khí:',
                    style: TextStyle(fontSize: 24),
                  )
                ],
              ),
            ),
            Container(
              margin:const EdgeInsets.symmetric(vertical: 20),
              child: air.getAirQualityWidget(36),
            ),
            Container(
              margin:const  EdgeInsets.only(bottom: 15),
              child: Text(
                air.getRecommended(),
                style: TextStyle(fontSize: 18),
              ),
            ),
            AirText(
              components: 'CO',
              value: air.cO,
              color: air.airColor,
            ),
            AirText(
              components: 'PM2.5',
              value: air.pm2_5,
              color: air.airColor,
            ),
            AirText(
              components: 'PM10',
              value: air.pm10,
              color: air.airColor,
            ),
            AirText(
              components: 'NH3',
              value: air.nH3,
              color: air.airColor,
            ),
            AirText(
              components: 'O3',
              value: air.o3,
              color: air.airColor,
            ),
            AirText(
              components: 'N02',
              value: air.nO2,
              color: air.airColor,
            ),
          ],
        ),
      ),
    );
  }
}

class AirText extends StatelessWidget {
  final String components;
  final dynamic value;
  final Color color;
  const AirText({Key key, this.components, this.value, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin:const EdgeInsets.only(bottom: 8),
      width: size.width / 2,
      child: Row(
        children: [
          Text(
            components,
            style: TextStyle(fontSize: 16),
          ),
          const Spacer(),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 16,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
