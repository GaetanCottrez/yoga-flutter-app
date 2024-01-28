import '../entities/statistics.dart';

abstract class IUserRepository {
  Future<StatsData> getStatistics();
}
