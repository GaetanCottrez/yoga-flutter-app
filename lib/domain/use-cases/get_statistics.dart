import 'package:yoga_training_app/domain/entities/statistics.dart';
import 'package:yoga_training_app/domain/repositories/user.repository.dart';
import 'package:yoga_training_app/domain/use-cases/use-cases.interface.dart';

class GetStatisticsUseCase implements IGetStatisticsUseCase {
  final IUserRepository userRepository;

  GetStatisticsUseCase(this.userRepository);

  @override
  Future<StatsData> call() async {
    return await userRepository.getStatistics();
  }
}
