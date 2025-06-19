import 'package:flutter/material.dart';
import 'package:pitangent_assignment/screens/home/home_presentation/home_screen.dart';
import 'package:pitangent_assignment/screens/onboarding/onborading_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRoute.initial:
        return MaterialPageRoute(builder: (_) => OnboradingScreen());
      case AppRoute.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => OnboradingScreen());
    }
  }
}

class AppRoute {
  static const String initial = "/";
  static const String home = "/home";
}
