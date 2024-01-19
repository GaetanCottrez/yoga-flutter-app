import 'package:flutter/material.dart';
import 'package:yoga_training_app/features/home/presentation/widgets/courses.dart';
import 'package:yoga_training_app/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:yoga_training_app/features/home/presentation/widgets/beginners.dart';

import 'package:yoga_training_app/core/constants/constants.dart';

import 'package:yoga_training_app/domain/use-cases/get_all_courses.dart';
import 'package:yoga_training_app/injections/course.injection.dart';

import 'package:yoga_training_app/domain/use-cases/get_beginner_courses.dart';

import 'package:yoga_training_app/shared/curved_navigation_bar_builder.dart';

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
      bottomNavigationBar: CurvedNavigationBarBuilder(
        selectedIndex: selectedIconIndex,
        onNavigationTap: (index) {
          setState(() {
            selectedIconIndex = index;
          });
        },
      ),
    );
  }
}
