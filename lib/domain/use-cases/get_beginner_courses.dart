import 'package:yoga_training_app/domain/repositories/course_repository.dart';
import 'package:yoga_training_app/domain/entities/course.dart';

class GetBeginnerCoursesUseCase {
  final ICourseRepository courseRepository;

  GetBeginnerCoursesUseCase(this.courseRepository);

  Future<List<Course>> call() async {
    return await courseRepository.getBeginnerCourses();
  }
}
