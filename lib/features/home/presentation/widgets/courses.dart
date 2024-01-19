import 'package:flutter/material.dart';
import 'package:yoga_training_app/domain/entities/course.dart';
import 'package:yoga_training_app/core/constants/constants.dart';
import 'package:yoga_training_app/features/startup/presentation/pages/startup_screen.dart';
import 'package:yoga_training_app/domain/use-cases/get_all_courses.dart';

class Courses extends StatelessWidget {
  final GetAllCoursesUseCase _getAllCoursesUseCase;

  Courses({required GetAllCoursesUseCase getAllCoursesUseCase})
      : _getAllCoursesUseCase = getAllCoursesUseCase;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: appPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Courses',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  'See All',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: primary),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Course>>(
              future: _getAllCoursesUseCase.call(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // The scroll is still being written, show a loading indicator
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // The ink has spilled, let’s display an error
                  return Center(child: Text('Error loading courses'));
                } else if (snapshot.hasData) {
                  // The scroll is ready to be revealed
                  List<Course> courses = snapshot.data!.take(5).toList();
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      return _buildCourses(context, courses[index]);
                    },
                  );
                } else {
                  // The scroll is blank, no courses found
                  return Center(child: Text('No courses found'));
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCourses(BuildContext context, Course course) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: appPadding, vertical: appPadding / 2),
      child: Container(
        height: size.height * 0.2,
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                  color: black.withOpacity(0.3),
                  blurRadius: 30.0,
                  offset: Offset(10, 15))
            ]),
        child: Padding(
          padding: const EdgeInsets.all(appPadding),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StartupScreen(course: course)));
            },
            child: Row(
              children: [
                Container(
                  width: size.width * 0.3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(course.imageUrl),
                  ),
                ),
                Container(
                  width: size.width * 0.5,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: appPadding / 2, top: appPadding / 1.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text(
                            course.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 2,
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_right_alt_rounded,
                            color: black.withOpacity(0.3),
                          ),
                        ]),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.folder_open_rounded,
                              color: black.withOpacity(0.3),
                            ),
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            Text(
                              course.students,
                              style: TextStyle(
                                color: black.withOpacity(0.3),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_outlined,
                              color: black.withOpacity(0.3),
                            ),
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            Text(
                              course.time.toString() + ' min',
                              style: TextStyle(
                                color: black.withOpacity(0.3),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
