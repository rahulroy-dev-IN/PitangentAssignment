import 'package:flutter/material.dart';
import 'package:pitangent_assignment/screens/onboarding/onborading_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => OnboradingScreen());
      default:
        return MaterialPageRoute(builder: (_) => OnboradingScreen());
    }
  }
}

class AppRoute {
  static const String initial = "/";
  static const String home = "/home";
}
