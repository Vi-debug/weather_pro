import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_pro/screen/main_screen1/body/body_section.dart';
import 'package:weather_pro/viewmodels/main_screen_view_model.dart';

import 'appbar/custom_appbar.dart';

class MainInfo extends StatelessWidget {
  const MainInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ChangeNotifierProvider(
        create: (BuildContext context) => MainScreenViewModel(),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: CustomAppBar(),
            ),
            Expanded(
              flex: 7,
              child: BodyMainSection(),
            ),
          ],
        ),
      ),
    );
  }
}
