import 'package:yoga_training_app/domain/entities/statistics.dart';

abstract class IUserDataSource {
  Future<StatsData> getStatistics(String accessToken);
}
