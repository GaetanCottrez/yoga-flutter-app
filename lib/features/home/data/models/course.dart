import 'package:yoga_training_app/features/home/data/models/pose.dart';

class Course {
  final String imageUrl;
  final String name;
  final String description;
  final int time;
  final String students;
  final List<Pose> poses;

  Course(
      {required this.imageUrl,
      required this.name,
      required this.description,
      required this.time,
      required this.students,
      required this.poses});
}
