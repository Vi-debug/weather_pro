import 'package:flutter/material.dart';
import 'package:weather_pro/screen/main_screen1/info_section.dart';
import 'background.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(),
        Positioned.fill(child: Container(color: Colors.black12)),
        Positioned.fill(child: MainInfo()),
      ],
    );
  }
}
