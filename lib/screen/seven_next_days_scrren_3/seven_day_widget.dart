import 'package:flutter/material.dart';
import 'package:weather_pro/model/day_forecast.dart';

class SevenDaysWidget extends StatelessWidget {
  final List<DayForecast> listFollowingDays;
  const SevenDaysWidget(this.listFollowingDays);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: Column(
            children: [
              Card(
                elevation: 4,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              index == 0
                                  ? 'Hôm nay'
                                  : listFollowingDays[index].weekday == 7
                                      ? 'Chủ nhật'
                                      : 'Thứ ${listFollowingDays[index].weekday + 1}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              listFollowingDays[index].dayAndMonth,
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      listFollowingDays[index].img,
                      const Spacer(
                        flex: 2,
                      ),
                      const Text('Ngày  ', style: const TextStyle(fontSize: 14)),
                      Text(
                        '${listFollowingDays[index].avgTemperature}\u00B0',
                        style: TextStyle(fontSize: 18, color: Colors.yellow.shade800),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                      const Text('Đêm  ', style: const TextStyle(fontSize: 14)),
                      Text(
                        '${listFollowingDays[index].minTemperature}\u00B0',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: listFollowingDays.length,
    );
  }
}
