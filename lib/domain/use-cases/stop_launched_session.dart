import 'package:yoga_training_app/domain/entities/launched-session.dart';
import 'package:yoga_training_app/domain/repositories/launched-session.repository.dart';
import 'package:yoga_training_app/domain/use-cases/use-cases.interface.dart';

class StopLaunchedSessionUseCase implements IStopLaunchedSessionUseCase {
  final ILaunchedSessionRepository launchedSessionRepository;

  StopLaunchedSessionUseCase(this.launchedSessionRepository);

  @override
  Future<LaunchedSession> call(int sessionId) async {
    return await launchedSessionRepository.stopCourse(sessionId);
  }
}
