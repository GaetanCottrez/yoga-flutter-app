import 'package:yoga_training_app/features/home/data/models/course.dart';

final _course1 = Course(
    imageUrl: 'assets/images/course1.jpg',
    name: 'Advance Stretchings',
    time: 45,
    students: 'Advanced');

final _course2 = Course(
    imageUrl: 'assets/images/course2.jpg',
    name: 'Daily Yoga',
    time: 30,
    students: 'Intermediate');

final _course3 = Course(
    imageUrl: 'assets/images/course3.jpg',
    name: 'Meditation',
    time: 20,
    students: 'Beginner');

final List<Course> courses = [_course1, _course3, _course2];
