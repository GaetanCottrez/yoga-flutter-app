import 'package:flutter/material.dart';
import 'package:yoga_training_app/core/config/material_config.dart';
import 'package:yoga_training_app/core/error/exception.dart';
import 'package:yoga_training_app/domain/entities/course.dart';
import 'package:yoga_training_app/domain/use-cases/get_all_courses.dart';
import 'package:yoga_training_app/features/login/pages/login_screen.dart';
import 'package:yoga_training_app/features/startup/pages/startup_screen.dart';

import 'course_card_widget.dart';

class CoursesList extends StatelessWidget {
  final GetAllCoursesUseCase _getAllCoursesUseCase;

  const CoursesList(
      {Key? key, required GetAllCoursesUseCase getAllCoursesUseCase})
      : _getAllCoursesUseCase = getAllCoursesUseCase,
        super(key: key);

  Future<List<Course>> getAllCourses(BuildContext context) async {
    List<Course> courses = [];
    try {
      courses = await _getAllCoursesUseCase.call();
      // Update your UI with the courses
    } on UnauthorizedException catch (_) {
      // Navigate to LoginScreen if unauthorized
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
    return courses;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleListCourses(),
          Expanded(
            child: FutureBuilder<List<Course>>(
              future: getAllCourses(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // The scroll is still being written, show a loading indicator
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // The ink has spilled, let’s display an error
                  return const Center(child: Text('Error loading courses'));
                } else if (snapshot.hasData) {
                  // The scroll is ready to be revealed
                  List<Course> courses = snapshot.data!.take(5).toList();
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      return CourseCard(
                        course: courses[index],
                        onTap: () =>
                            _navigateToCourseDetails(context, courses[index]),
                      );
                    },
                  );
                } else {
                  // The scroll is blank, no courses found
                  return const Center(child: Text('No courses found'));
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget titleListCourses() {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: appPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Toutes les sessions',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
            ),
          ),
          Text(
            'Voir tout',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w800, color: primary),
          ),
        ],
      ),
    );
  }

  void _navigateToCourseDetails(BuildContext context, Course course) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => StartupScreen(course: course)));
  }
}
