import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:yoga_training_app/features/home/presentation/widgets/courses.dart';
import 'package:yoga_training_app/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:yoga_training_app/features/home/presentation/widgets/beginners.dart';

import 'package:yoga_training_app/core/constants/constants.dart';

import 'package:yoga_training_app/domain/use-cases/get_all_courses.dart';
import 'package:yoga_training_app/injections/course.injection.dart';

import 'package:yoga_training_app/domain/use-cases/get_beginner_courses.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GetAllCoursesUseCase getAllCoursesUseCase =
      InjectionContainer.provideGetAllCoursesUseCase();

  GetBeginnerCoursesUseCase getBeginnerCoursesUseCase =
      InjectionContainer.provideGetBeginnerCoursesUseCase();

  int selectedIconIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Padding(
        padding: EdgeInsets.only(top: appPadding * 2),
        child: Column(
          children: [
            CustomAppBar(),
            Beginners(
              getBeginnerCoursesUseCase: getBeginnerCoursesUseCase,
            ),
            Courses(getAllCoursesUseCase: getAllCoursesUseCase),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        index: selectedIconIndex,
        buttonBackgroundColor: primary,
        height: 60.0,
        color: white,
        onTap: (index) {
          setState(() {
            selectedIconIndex = index;
          });
        },
        animationDuration: Duration(
          milliseconds: 200,
        ),
        items: <Widget>[
          Icon(
            Icons.play_arrow_outlined,
            size: 30,
            color: selectedIconIndex == 0 ? white : black,
          ),
          Icon(
            Icons.search,
            size: 30,
            color: selectedIconIndex == 1 ? white : black,
          ),
          Icon(
            Icons.home_outlined,
            size: 30,
            color: selectedIconIndex == 2 ? white : black,
          ),
          Icon(
            Icons.favorite_border_outlined,
            size: 30,
            color: selectedIconIndex == 3 ? white : black,
          ),
          Icon(
            Icons.person_outline,
            size: 30,
            color: selectedIconIndex == 4 ? white : black,
          ),
        ],
      ),
    );
  }
}
