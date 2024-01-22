import 'package:flutter/material.dart';
import 'package:yoga_training_app/core/config/material_config.dart';
import 'package:yoga_training_app/core/error/exception.dart';
import 'package:yoga_training_app/domain/entities/course.dart';
import 'package:yoga_training_app/domain/use-cases/get_beginner_courses.dart';
import 'package:yoga_training_app/features/login/presentation/pages/login_screen.dart';
import 'package:yoga_training_app/features/startup/presentation/pages/startup_screen.dart';

class Beginners extends StatelessWidget {
  final GetBeginnerCoursesUseCase _getBeginnerCoursesUseCase;

  const Beginners(
      {Key? key, required GetBeginnerCoursesUseCase getBeginnerCoursesUseCase})
      : _getBeginnerCoursesUseCase = getBeginnerCoursesUseCase,
        super(key: key);

  Widget _buildBeginner(BuildContext context, Course beginner) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: appPadding / 2),
          child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StartupScreen(course: beginner)));
              },
              child: Container(
                margin: const EdgeInsets.only(
                    top: appPadding * 3, bottom: appPadding * 2),
                width: size.width * 0.4,
                height: size.height * 0.2,
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                        topRight: Radius.circular(100.0)),
                    boxShadow: [
                      BoxShadow(
                          color: black.withOpacity(0.3),
                          blurRadius: 20.0,
                          offset: const Offset(5, 15))
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: appPadding / 2,
                          right: appPadding * 3,
                          top: appPadding),
                      child: Text(
                        beginner.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: appPadding / 2,
                          right: appPadding / 2,
                          bottom: appPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                                '${beginner.time} min',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: black.withOpacity(0.3)),
                                maxLines: 2,
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: const Icon(
                              Icons.add,
                              color: white,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
        Positioned(
          right: 20,
          top: 60,
          child: Container(
            child: Image.network(beginner.imageUrl,
                width: size.width * 0.2, height: size.height * 0.2),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    getBeginnerCourses() async {
      List<Course> courses = [];
      try {
        courses = await _getBeginnerCoursesUseCase.call();
        // Update your UI with the courses
      } on UnauthorizedException catch (_) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
      return courses;
    }

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
              horizontal: appPadding, vertical: appPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'For Beginners',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                'See All',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w800, color: primary),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: appPadding / 2),
          child: FutureBuilder<List<Course>>(
            future: getBeginnerCourses(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: size.height * 0.33,
                  child: const Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return SizedBox(
                  height: size.height * 0.33,
                  child: Center(child: Text('Error: ${snapshot.error}')),
                );
              } else if (snapshot.hasData) {
                List<Course> beginners = snapshot.data!;
                return SizedBox(
                  height: size.height * 0.33,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: beginners.length > 5 ? 5 : beginners.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildBeginner(context, beginners[index]);
                    },
                  ),
                );
              } else {
                return SizedBox(
                  height: size.height * 0.33,
                  child: const Center(
                      child: Text('No beginners styles available')),
                );
              }
            },
          ),
        )
      ],
    );
  }
}
