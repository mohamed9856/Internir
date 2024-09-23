import 'package:flutter/material.dart';
import 'package:internir/utils/routes.dart';
import 'package:internir/utils/size_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'utils/app_theme.dart';
import 'screens/home/OneCategory.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      title: 'Internir',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      onGenerateRoute: AppRoute.onGenerateRoute,
      home: Onecategory(),
    );
  }
}
