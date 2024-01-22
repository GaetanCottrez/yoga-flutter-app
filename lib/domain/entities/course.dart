import 'dart:math';

import 'package:yoga_training_app/core/log/print.dart';
import 'package:yoga_training_app/domain/entities/pose.dart';

class Course {
  final int id;
  final String imageUrl;
  final String name;
  final String description;
  final int time;
  final String students;
  final List<Pose> poses;

  Course(
      {required this.id,
      required this.imageUrl,
      required this.name,
      required this.description,
      required this.time,
      required this.students,
      required this.poses});

  static MakeThisSession(Course course, int durationPose) {
    int courseTimeSeconds = ((course.time * 60) / (durationPose + 5)).round();
    if (course.poses.length < courseTimeSeconds) {
      int courseTimeSeconds = ((course.time * 60) / (durationPose + 5)).round();
      if (course.poses.length < courseTimeSeconds) {
        int posesToGenerate = courseTimeSeconds - course.poses.length;
        Random random = Random();
        // Generate `posesToGenerate` number of poses.
        for (int i = 0; i < posesToGenerate; i++) {
          // Make sure to generate a random index which is within the bounds of `course.poses`.
          int randomNumber = random.nextInt(course.poses.length);
          // Add an existing pose from `course.poses` based on the random index.
          course.poses.add(course.poses[randomNumber]);
        }
      }
    }
    printInternal('MakeThisSession');
    printInternal(course.poses.length);
    return course.poses;
  }
}
