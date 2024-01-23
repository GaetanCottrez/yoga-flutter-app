import 'package:flutter/material.dart';
import 'package:yoga_training_app/core/config/material_config.dart';
import 'package:yoga_training_app/domain/entities/course.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;

  const CourseCard({
    Key? key,
    required this.course,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
              offset: const Offset(10, 15),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(appPadding),
          child: GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                CourseImage(imageUrl: course.imageUrl, width: size.width * 0.3),
                CourseDetails(course: course, width: size.width * 0.5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CourseImage extends StatelessWidget {
  final String imageUrl;
  final double width;

  const CourseImage({
    Key? key,
    required this.imageUrl,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.network(imageUrl, fit: BoxFit.cover),
      ),
    );
  }
}

class CourseDetails extends StatelessWidget {
  final Course course;
  final double width;

  const CourseDetails({
    Key? key,
    required this.course,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Padding(
        padding:
            const EdgeInsets.only(left: appPadding / 2, top: appPadding / 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CourseTitle(name: course.name),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            CourseStatistics(
              icon: Icons.folder_open_rounded,
              text: course.students,
              opacity: 0.3,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            CourseStatistics(
              icon: Icons.access_time_outlined,
              text: '${course.time} min',
              opacity: 0.3,
            ),
          ],
        ),
      ),
    );
  }
}

class CourseStatistics extends StatelessWidget {
  final IconData icon;
  final String text;
  final double opacity;

  const CourseStatistics({
    Key? key,
    required this.icon,
    required this.text,
    required this.opacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: black.withOpacity(opacity)),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(color: black.withOpacity(opacity))),
      ],
    );
  }
}

class CourseTitle extends StatelessWidget {
  final String name;

  const CourseTitle({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Icon(
          Icons.arrow_right_alt_rounded,
          color: black,
        ),
      ],
    );
  }
}
