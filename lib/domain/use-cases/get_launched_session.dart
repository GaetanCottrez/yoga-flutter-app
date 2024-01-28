import 'package:yoga_training_app/domain/entities/launched-session.dart';
import 'package:yoga_training_app/domain/repositories/launched-session.repository.dart';
import 'package:yoga_training_app/domain/use-cases/use-cases.interface.dart';

class GetLaunchedSessionUseCase implements IGetLaunchedSessionUseCase {
  final ILaunchedSessionRepository launchedSessionRepository;

  GetLaunchedSessionUseCase(this.launchedSessionRepository);

  @override
  Future<LaunchedSession?> call() async {
    return await launchedSessionRepository.activeCourse();
  }
}
