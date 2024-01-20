import 'package:yoga_training_app/domain/repositories/course.repository.dart';
import 'package:yoga_training_app/domain/entities/course.dart';

class GetAllCoursesUseCase {
  final ICourseRepository courseRepository;

  GetAllCoursesUseCase(this.courseRepository);

  Future<List<Course>> call() async {
    return await courseRepository.getAllCourses();
  }
}
