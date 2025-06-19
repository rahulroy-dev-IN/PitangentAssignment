import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pitangent_assignment/global/di/dependency_injection.dart';
import 'package:pitangent_assignment/screens/home/home_logic/favorite_bloc.dart';
import 'package:pitangent_assignment/screens/home/home_logic/products_bloc.dart';
import 'package:pitangent_assignment/screens/home/home_presentation/home_screen.dart';
import 'package:pitangent_assignment/screens/onboarding/onborading_screen.dart';
import 'package:pitangent_assignment/screens/splash/splash_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRoute.initial:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case AppRoute.onboarding:
        return MaterialPageRoute(builder: (_) => OnboradingScreen());
      case AppRoute.home:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: getIt<ProductsBloc>()),
              BlocProvider.value(value: getIt<FavoriteBloc>()),
            ],
            child: HomeScreen(),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => OnboradingScreen());
    }
  }
}

class AppRoute {
  static const String initial = "/";
  static const String home = "/home";
  static const String onboarding = "/onboarding";
}
