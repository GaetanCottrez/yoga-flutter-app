import 'package:flutter/material.dart';
import 'package:yoga_training_app/core/config/material_config.dart';
import 'package:yoga_training_app/core/error/exception.dart';
import 'package:yoga_training_app/domain/entities/course.dart';
import 'package:yoga_training_app/domain/use-cases/get_beginner_courses.dart';
import 'package:yoga_training_app/features/login/pages/login_screen.dart';

import 'beginner_card_widget.dart';

class BeginnersList extends StatelessWidget {
  final GetBeginnerCoursesUseCase getBeginnerCoursesUseCase;

  const BeginnersList({Key? key, required this.getBeginnerCoursesUseCase})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BeginnersHeader(),
        BeginnersCoursesList(
            getBeginnerCoursesUseCase: getBeginnerCoursesUseCase),
      ],
    );
  }
}

class BeginnersHeader extends StatelessWidget {
  const BeginnersHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding:
          EdgeInsets.symmetric(horizontal: appPadding, vertical: appPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Pour débutant',
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
}

class BeginnersCoursesList extends StatefulWidget {
  final GetBeginnerCoursesUseCase getBeginnerCoursesUseCase;

  const BeginnersCoursesList(
      {Key? key, required this.getBeginnerCoursesUseCase})
      : super(key: key);

  @override
  _BeginnersCoursesListState createState() => _BeginnersCoursesListState();
}

class _BeginnersCoursesListState extends State<BeginnersCoursesList> {
  late final Future<List<Course>> _coursesFuture;

  @override
  void initState() {
    super.initState();
    _coursesFuture = _getBeginnerCourses();
  }

  Future<List<Course>> _getBeginnerCourses() async {
    try {
      return await widget.getBeginnerCoursesUseCase.call();
    } on UnauthorizedException catch (_) {
      // Make sure to check authentication status before calling this
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: appPadding / 2),
      child: FutureBuilder<List<Course>>(
        future: _coursesFuture,
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
                  return BeginnerCard(
                    beginner: beginners[index],
                    width: size.width,
                    height: size.height,
                  ); // Assuming this is another widget
                },
              ),
            );
          } else {
            return SizedBox(
              height: size.height * 0.33,
              child: const Center(child: Text('No beginners styles available')),
            );
          }
        },
      ),
    );
  }
}
