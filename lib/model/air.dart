import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Air {
  final dynamic cO, nO2, o3, sO2, pm10, nH3, pm2_5;
  final int overall;
  Color airColor;
  Air(
      {this.overall,
      this.cO,
      this.nO2,
      this.o3,
      this.sO2,
      this.pm2_5,
      this.pm10,
      this.nH3});

  Widget getAirQualityWidget(double size) {
    airColor = getAirColor();
    switch (overall) {
      case 1:
        return Text(
          'Rất tốt',
          style: TextStyle(
              fontSize: size,
              color: airColor,
              fontWeight: FontWeight.w700),
        );
      case 2:
        return Text(
          'Tốt',
          style: TextStyle(
              fontSize: size, color: airColor, fontWeight: FontWeight.w700),
        );
      case 3:
        return Text(
          'Trung bình',
          style: TextStyle(
              fontSize: size,
              color: airColor,
              fontWeight: FontWeight.w700),
        );
      case 4:
        return Text(
          'Xấu',
          style: TextStyle(
              fontSize: size,
              color: airColor,
              fontWeight: FontWeight.w700),
        );
      case 5:
        return Text(
          'Rất xấu',
          style: TextStyle(
              fontSize: size,
              color: airColor,
              fontWeight: FontWeight.w700),
        );
      default:
        return null;
    }
  }

  String getAirQualityText() {
    switch (overall) {
      case 1:
        return 'Rất tốt';
      case 2:
        return 'Tốt';
      case 3:
        return 'Trung Bình';
      case 4:
        return 'Xấu';
      case 5:
        return 'Rất Xấu';
      default:
        return null;
    }
  }

  String getRecommended() {
    switch (overall) {
      case 1:
        return 'Một ngày đẹp trời để đi dạo';
      case 2:
        return 'Không khí tuyệt vời';
      case 3:
        return 'Cẩn thận nếu bạn quá nhạy cảm';
      case 4:
        return 'Hãy đeo khẩu trang khi ra ngoài nhé';
      case 5:
        return 'Hạn chế ra ngoài nha bạn';
      default:
        return null;
    }
  }

  Color getAirColor() {
    switch (overall) {
      case 1:
        return Colors.greenAccent.shade400;
      case 2:
        return Colors.green;
      case 3:
        return Colors.yellow.shade800;
      case 4:
        return Colors.red.shade400;
      case 5:
        return Colors.red.shade900;
      default:
        return null;
    }
  }
}
