import 'dart:math';

import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  static Color getRandomLightColor() {
    final rand = Random();
    return Color.fromARGB(
      255,
      180 + rand.nextInt(76),
      180 + rand.nextInt(76),
      180 + rand.nextInt(76),
    );
  }

  static const MaterialColor primary = MaterialColor(0xFF000000, {
    50: Color(0xFFebecf0),
    100: Color(0xFFc0c3ce),
    200: Color(0xFF90979e),
    300: Color(0xFF767c82),
    400: Color(0xFF515254),
    500: Color(0xFF333436),
    600: Color(0xFF232424),
    700: Color(0xFF161d1d),
    800: Color(0xFF0B100E),
    900: Color(0xFF000000),
  });

  static const Color white = Color(0xFFFFFFFF);

  static const Color red = Color(0xFFFF0000);
}
