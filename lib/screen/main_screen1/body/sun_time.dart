import 'package:flutter/material.dart';

class SunTime extends StatelessWidget {
  final String sunRiseTime;
  final String sunSetTime;

  SunTime(this.sunRiseTime, this.sunSetTime);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: RiseSetTime(time: sunRiseTime, isDawn: true)),
        Expanded(child: RiseSetTime(time: sunSetTime, isDawn: false)),
      ],
    );
  }
}

class RiseSetTime extends StatelessWidget {
  final String time;
  final bool isDawn;

  const RiseSetTime({Key key, this.time, this.isDawn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          isDawn ? "Bình minh" : "Hoàng hôn",
          style: TextStyle(color: Color.fromRGBO(255,255,255,0.85), fontSize: 18),
        ),
        Text(
          time,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24
          ),
        ),
      ],
    );
  }
}
