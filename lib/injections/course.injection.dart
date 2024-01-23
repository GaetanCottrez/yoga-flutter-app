import 'package:yoga_training_app/domain/data-sources/course.data-source.dart';
import 'package:yoga_training_app/domain/data-sources/launched-session.data-source.dart';
import 'package:yoga_training_app/domain/repositories/course.repository.dart';
import 'package:yoga_training_app/domain/repositories/launched-session.repository.dart';
import 'package:yoga_training_app/domain/use-cases/get_all_courses.dart';
import 'package:yoga_training_app/domain/use-cases/get_beginner_courses.dart';
import 'package:yoga_training_app/domain/use-cases/get_launched_session.dart';
import 'package:yoga_training_app/domain/use-cases/search_courses.dart';
import 'package:yoga_training_app/domain/use-cases/start_launched_session.dart';
import 'package:yoga_training_app/domain/use-cases/stop_launched_session.dart';
import 'package:yoga_training_app/repositories/courses/course.remote.dart';
import 'package:yoga_training_app/repositories/courses/course.repository.dart';
import 'package:yoga_training_app/repositories/launched-sessions/launched-session.remote.dart';
import 'package:yoga_training_app/repositories/launched-sessions/launched-session.repository.dart';
import 'package:yoga_training_app/repositories/token.dart';

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

  static GetLaunchedSessionUseCase provideGetLaunchedSessionUseCase() {
    ILaunchedSessionDataSource dataSource = LaunchedSessionRemoteDataSource();
    TokenStorage tokenStorage = TokenStorage();
    ILaunchedSessionRepository repository =
        LaunchedSessionRepository(dataSource, tokenStorage);
    return GetLaunchedSessionUseCase(repository);
  }

  static StopLaunchedSessionUseCase provideStopLaunchedSessionUseCase() {
    ILaunchedSessionDataSource dataSource = LaunchedSessionRemoteDataSource();
    TokenStorage tokenStorage = TokenStorage();
    ILaunchedSessionRepository repository =
        LaunchedSessionRepository(dataSource, tokenStorage);
    return StopLaunchedSessionUseCase(repository);
  }

  static StartLaunchedSessionUseCase provideStartLaunchedSessionUseCase() {
    ILaunchedSessionDataSource dataSource = LaunchedSessionRemoteDataSource();
    TokenStorage tokenStorage = TokenStorage();
    ILaunchedSessionRepository repository =
        LaunchedSessionRepository(dataSource, tokenStorage);
    return StartLaunchedSessionUseCase(repository);
  }

  static SearchCoursesUseCase provideSearchCoursesUseCase() {
    ICourseDataSource dataSource = CourseRemoteDataSource();
    TokenStorage tokenStorage = TokenStorage();
    ICourseRepository repository = CourseRepository(dataSource, tokenStorage);
    return SearchCoursesUseCase(repository);
  }
}
