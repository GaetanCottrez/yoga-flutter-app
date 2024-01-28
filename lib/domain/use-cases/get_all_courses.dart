import 'package:yoga_training_app/domain/entities/course.dart';
import 'package:yoga_training_app/domain/repositories/course.repository.dart';
import 'package:yoga_training_app/domain/use-cases/use-cases.interface.dart';

class GetAllCoursesUseCase implements IGetAllCoursesUseCase {
  final ICourseRepository courseRepository;

  GetAllCoursesUseCase(this.courseRepository);

  @override
  Future<List<Course>> call() async {
    return await courseRepository.getAllCourses();
  }
}
