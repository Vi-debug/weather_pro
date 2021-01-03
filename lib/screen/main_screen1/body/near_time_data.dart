import 'package:flutter/material.dart';
import 'package:weather_pro/model/near_time_data.dart';

class NearTimeSection extends StatelessWidget {
  final List<NearTimeData> listNearTime;
  NearTimeSection(this.listNearTime);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  listNearTime[index].time,
                  style: TextStyle(color: Color.fromRGBO(240, 240, 240, 0.9)),
                ),
                Text(listNearTime[index].temp.toString() + '\u00B0',
                    style: TextStyle(color: Colors.white)),
                listNearTime[index].img,
                Text(
                  '${(listNearTime[index].windSpeed * 3600 / 1000).toStringAsFixed(1)} km/h',
                  style: TextStyle(color: Color.fromRGBO(240, 240, 240, 0.9)),
                ),
              ],
            ),
          );
        },
        itemCount: listNearTime.length,
      ),
    );
  }
}
