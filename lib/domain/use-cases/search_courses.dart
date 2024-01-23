import 'package:yoga_training_app/domain/entities/course.dart';
import 'package:yoga_training_app/domain/repositories/course.repository.dart';

class SearchCoursesUseCase {
  final ICourseRepository courseRepository;

  SearchCoursesUseCase(this.courseRepository);

  Future<List<Course>> call(String term) async {
    return await courseRepository.searchCourses(term);
  }
}
