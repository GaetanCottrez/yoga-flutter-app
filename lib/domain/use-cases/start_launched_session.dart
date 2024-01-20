import 'package:yoga_training_app/domain/entities/launched-session.dart';
import 'package:yoga_training_app/domain/repositories/launched-session.repository.dart';

class StartLaunchedSessionUseCase {
  final ILaunchedSessionRepository launchedSessionRepository;

  StartLaunchedSessionUseCase(this.launchedSessionRepository);

  Future<LaunchedSession> call(int sessionId) async {
    return await launchedSessionRepository.startCourse(sessionId);
  }
}
