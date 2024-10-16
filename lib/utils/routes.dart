import 'package:flutter/material.dart';
import 'package:internir/screens/layout/home_layout.dart';
import 'package:internir/screens/splash/splash_screen.dart';
import 'package:internir/screens/onboarding/onboarding_screen.dart';
import '../models/job_model.dart';
import '../screens/apply/apply_screen.dart';
import '../screens/apply/apply_to_job.dart';
import '../screens/layout/home_layout.dart';
import '../screens/splash/splash_screen.dart';

class AppRoute {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeLayout.routeName:
        return MaterialPageRoute(builder: (_) => const HomeLayout());

      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case OnBoardingScreen.routeName:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

      case ApplyScreen.routeName:
        final job = settings.arguments as JobModel;
        return MaterialPageRoute(builder: (_) => ApplyScreen(job: job));

      case ApplyToJob.routeName:
        final job = settings.arguments as JobModel;
        return MaterialPageRoute(builder: (_) => ApplyToJob(job: job));

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
