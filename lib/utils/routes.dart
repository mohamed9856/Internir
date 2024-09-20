import 'package:flutter/material.dart';

class AppRoute {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case '/':
      //   return MaterialPageRoute(builder: (_) => const MyHomePage());
      // case '/second':
      //   return MaterialPageRoute(builder: (_) => const SecondPage());
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
