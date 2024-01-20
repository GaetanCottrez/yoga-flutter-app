import 'package:yoga_training_app/domain/entities/launched-session.dart';

abstract class ILaunchedSessionRepository {
  Future<LaunchedSession?> activeCourse();

  Future<LaunchedSession> startCourse(int sessionId);

  Future<LaunchedSession> stopCourse(int sessionId);
}
