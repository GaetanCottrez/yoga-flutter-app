import 'package:flutter/material.dart';
import 'package:yoga_training_app/features/home/presentation/pages/home_screen.dart';
import 'package:yoga_training_app/features/login/presentation/pages/login_screen.dart';
import 'package:yoga_training_app/features/splash/presentation/pages/SplashScreen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Yoga App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const SplashScreen(),
        routes: {
          '/home': (context) => const HomeScreen(),
          '/login': (context) => const LoginScreen(),
        });
  }
}
