import 'package:yoga_training_app/domain/data-sources/course.data-source.dart';
import 'package:yoga_training_app/domain/repositories/course_repository.dart';
import 'package:yoga_training_app/repositories/token.dart';
import 'package:yoga_training_app/repositories/courses/course.remote.dart';
import 'package:yoga_training_app/repositories/courses/course.repository.dart';
import 'package:yoga_training_app/domain/use-cases/get_all_courses.dart';
import 'package:yoga_training_app/domain/use-cases/get_beginner_courses.dart';

class InjectionContainer {
  static GetAllCoursesUseCase provideGetAllCoursesUseCase() {
    ICourseDataSource dataSource = CourseRemoteDataSource();
    TokenStorage tokenStorage = TokenStorage();
    ICourseRepository repository = CourseRepository(dataSource, tokenStorage);
    return GetAllCoursesUseCase(repository);
  }

  static GetBeginnerCoursesUseCase provideGetBeginnerCoursesUseCase() {
    ICourseDataSource dataSource = CourseRemoteDataSource();
    TokenStorage tokenStorage = TokenStorage();
    ICourseRepository repository = CourseRepository(dataSource, tokenStorage);
    return GetBeginnerCoursesUseCase(repository);
  }
}
