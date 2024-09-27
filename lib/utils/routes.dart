import 'package:flutter/material.dart';
import 'package:internir/screens/layout/home_layout.dart';
import 'package:internir/screens/splash/splash_screen.dart';

class AppRoute {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeLayout.routeName:
        return MaterialPageRoute(builder: (_) => const HomeLayout());
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      default:
        return MaterialPageRoute(builder: (_) => errorRoute());
    }
  }

  static Widget errorRoute() {
    return const Scaffold(
      body: Center(
        child: Text('Error: Route not found'),
      ),
    );
  }
}
