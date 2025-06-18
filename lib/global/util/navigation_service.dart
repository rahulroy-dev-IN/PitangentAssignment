import 'package:flutter/material.dart';

class NavigationService {
  final navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {arguments}) async {
    return navigatorKey.currentState?.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> navigateAndRemove(String routeName, {arguments}) async {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }
}
