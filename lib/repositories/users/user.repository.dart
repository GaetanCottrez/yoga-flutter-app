import 'package:yoga_training_app/domain/data-sources/user.data-source.dart';
import 'package:yoga_training_app/domain/entities/statistics.dart';
import 'package:yoga_training_app/domain/repositories/user.repository.dart';
import 'package:yoga_training_app/repositories/token.dart';

class UserRepository implements IUserRepository {
  final IUserDataSource dataSource;
  final TokenStorage tokenStorage;

  UserRepository(this.dataSource, this.tokenStorage);

  @override
  Future<StatsData> getStatistics() async {
    var accessToken = await tokenStorage.getAccessToken();
    return dataSource.getStatistics(accessToken);
  }
}
