import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internir/providers/jobs_provider.dart';
import 'package:internir/utils/app_assets.dart';
import 'package:internir/utils/app_color.dart';
import 'package:internir/utils/size_config.dart';
import 'package:internir/screens/layout/home_layout.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      futureCall();
    });
  }

  futureCall() async {
    var jobProvider = Provider.of<JobsProvider>(context, listen: false);
    await jobProvider.fetchJobs();
    await jobProvider.fetchCategories();
    print(jobProvider.loading.toString() + "loooooooooooooooooooooo");

    await Future.delayed(const Duration(seconds: 2));

    Navigator.pushReplacementNamed(context, HomeLayout.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Internir.jpg',
              width: 350 * SizeConfig.horizontalBlock,
              height: 350 * SizeConfig.verticalBlock,
            ),
            SizedBox(height: 20 * SizeConfig.verticalBlock),
            Text(
              'Discover Your Future Opportunity',
              style: TextStyle(
                fontSize: 20 * SizeConfig.textRatio,
                fontWeight: FontWeight.bold,
                color: AppColor.mainBlue,
              ),
            ),
            SizedBox(height: 20 * SizeConfig.verticalBlock),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
