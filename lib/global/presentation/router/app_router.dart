import 'package:flutter/material.dart';
import 'package:pitangent_assignment/main.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => MyHomePage(title: routeSettings.arguments as String),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => MyHomePage(title: routeSettings.arguments as String),
        );
    }
  }
}

class AppRoute {
  static const String initial = "/";
  static const String home = "/home";
}
