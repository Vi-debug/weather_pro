import 'package:flutter/material.dart';
import 'package:weather_pro/viewmodels/main_screen_view_model.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    var futureWeather = MainScreenViewModel().getWeather();
    futureWeather.then((weather) => Navigator.of(context)
        .pushReplacementNamed('/main_screen', arguments: weather));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: null,
      body: Container(
        alignment: Alignment.center,
        color: Color.fromRGBO(44, 42, 54, 1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Weather',
                  style: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w500,
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  ' PRO',
                  style: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Image.asset('assets/weather.gif'),
            const Text(
              'a product of Art',
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
