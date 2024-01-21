import 'package:flutter/material.dart';
import 'package:yoga_training_app/features/home/presentation/pages/home_screen.dart';
import 'package:yoga_training_app/features/login/presentation/pages/login_screen.dart';
import 'package:yoga_training_app/features/splash/presentation/pages/SplashScreen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Yoga App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
        routes: {
          '/home': (context) => HomeScreen(),
          '/login': (context) => LoginScreen(),
        });
  }
}
