import 'package:flutter/material.dart';
import 'package:yoga_training_app/core/config/material_config.dart';
import 'package:yoga_training_app/domain/entities/course.dart';
import 'package:yoga_training_app/features/startup/pages/startup_screen.dart';

class BeginnerCard extends StatelessWidget {
  final Course beginner;
  final double width;
  final double height;

  const BeginnerCard({
    Key? key,
    required this.beginner,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: () => _navigateToCourse(context, beginner),
          child: Container(
            margin: const EdgeInsets.only(
                top: appPadding * 3, bottom: appPadding * 2),
            width: width * 0.4,
            height: height * 0.2,
            decoration: BoxDecoration(
              color: white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
                topRight: Radius.circular(100.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: black.withOpacity(0.3),
                  blurRadius: 20.0,
                  offset: const Offset(5, 15),
                ),
              ],
            ),
            child: CourseInfo(beginner: beginner),
          ),
        ),
        CourseThumbnail(
            imageUrl: beginner.imageUrl,
            width: width * 0.2,
            height: height * 0.2),
      ],
    );
  }

  void _navigateToCourse(BuildContext context, Course course) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StartupScreen(course: course)),
    );
  }
}

class CourseInfo extends StatelessWidget {
  final Course beginner;

  const CourseInfo({
    Key? key,
    required this.beginner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: appPadding / 2, right: appPadding * 3, top: appPadding),
          child: Text(
            beginner.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            maxLines: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: appPadding / 2, right: appPadding / 2, bottom: appPadding),
          child: CourseDurationAndAddButton(beginner: beginner),
        ),
      ],
    );
  }
}

class CourseThumbnail extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const CourseThumbnail({
    Key? key,
    required this.imageUrl,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      top: height / 3, // Adjust the top value as needed
      child: Image.network(imageUrl, width: width, height: height),
    );
  }
}

class CourseDurationAndAddButton extends StatelessWidget {
  final Course beginner;

  const CourseDurationAndAddButton({
    Key? key,
    required this.beginner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.access_time_outlined,
              color: black,
            ),
            const SizedBox(width: 4),
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
              color: primary, borderRadius: BorderRadius.circular(5.0)),
          child: const Icon(Icons.add, color: white),
        ),
      ],
    );
  }
}
