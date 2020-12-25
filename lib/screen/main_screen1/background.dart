import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        'assets/sunny1.jpeg',
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
