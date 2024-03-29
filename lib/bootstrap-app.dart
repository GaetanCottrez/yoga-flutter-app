import 'package:flutter/material.dart';
import 'package:yoga_training_app/features/home/pages/home_screen.dart';
import 'package:yoga_training_app/features/login/pages/login_screen.dart';
import 'package:yoga_training_app/features/search/pages/search_screen.dart';
import 'package:yoga_training_app/features/splash/splash_screen.dart';
import 'package:yoga_training_app/features/statistics/pages/statistics_screen.dart';
import 'package:yoga_training_app/injections/course.injection.dart';

HomeScreen instanceHomeScreen = HomeScreen(
    getAllCoursesUseCase: InjectionContainer.provideGetAllCoursesUseCase(),
    getBeginnerCoursesUseCase:
        InjectionContainer.provideGetBeginnerCoursesUseCase(),
    getLaunchedSessionUseCase:
        InjectionContainer.provideGetLaunchedSessionUseCase(),
    stopLaunchedSessionUseCase:
        InjectionContainer.provideStopLaunchedSessionUseCase());

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
          '/home': (context) => instanceHomeScreen,
          '/login': (context) => const LoginScreen(),
          '/search': (context) => const SearchScreen(),
          '/stats': (context) => StatisticsScreen(
              getStatistics: InjectionContainer.provideGetStatisticsUseCase()),
        });
  }
}
