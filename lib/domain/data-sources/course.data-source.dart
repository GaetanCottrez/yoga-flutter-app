import 'package:yoga_training_app/domain/entities/course.dart';

abstract class ICourseDataSource {
  Future<List<Course>> getAllCourses(String accessToken);

  Future<List<Course>> getBeginnerCourses(String accessToken);

  Future<List<Course>> searchCourses(String accessToken, String term);
}
