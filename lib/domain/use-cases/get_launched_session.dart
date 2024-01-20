import 'package:yoga_training_app/domain/entities/launched-session.dart';
import 'package:yoga_training_app/domain/repositories/launched-session.repository.dart';

class GetLaunchedSessionUseCase {
  final ILaunchedSessionRepository launchedSessionRepository;

  GetLaunchedSessionUseCase(this.launchedSessionRepository);

  Future<LaunchedSession?> call() async {
    return await launchedSessionRepository.activeCourse();
  }
}
