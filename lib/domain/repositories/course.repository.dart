import 'package:yoga_training_app/domain/entities/course.dart';

abstract class ICourseRepository {
  Future<List<Course>> getAllCourses();

  Future<List<Course>> getBeginnerCourses();

  Future<List<Course>> searchCourses(String term);
}
