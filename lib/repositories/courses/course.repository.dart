import 'package:yoga_training_app/domain/data-sources/course.data-source.dart';
import 'package:yoga_training_app/domain/entities/course.dart';
import 'package:yoga_training_app/domain/repositories/course.repository.dart';
import 'package:yoga_training_app/repositories/token.dart';

class CourseRepository implements ICourseRepository {
  final ICourseDataSource dataSource;
  final TokenStorage tokenStorage;

  CourseRepository(this.dataSource, this.tokenStorage);

  @override
  Future<List<Course>> getAllCourses() async {
    var accessToken = await tokenStorage.getAccessToken();
    return dataSource.getAllCourses(accessToken);
  }

  @override
  Future<List<Course>> getBeginnerCourses() async {
    var accessToken = await tokenStorage.getAccessToken();
    return dataSource.getBeginnerCourses(accessToken);
  }

  @override
  Future<List<Course>> searchCourses(String term) async {
    var accessToken = await tokenStorage.getAccessToken();
    return dataSource.searchCourses(accessToken, term);
  }
}
