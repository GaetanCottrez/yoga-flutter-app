import 'package:yoga_training_app/domain/data-sources/launched-session.data-source.dart';
import 'package:yoga_training_app/domain/entities/launched-session.dart';
import 'package:yoga_training_app/domain/repositories/launched-session.repository.dart';
import 'package:yoga_training_app/repositories/token.dart';

class LaunchedSessionRepository implements ILaunchedSessionRepository {
  final ILaunchedSessionDataSource dataSource;
  final TokenStorage tokenStorage;

  LaunchedSessionRepository(this.dataSource, this.tokenStorage);

  @override
  Future<LaunchedSession?> activeCourse() async {
    var accessToken = await tokenStorage.getAccessToken();
    return dataSource.activeSession(accessToken);
  }

  @override
  Future<LaunchedSession> startCourse(int sessionId) async {
    var accessToken = await tokenStorage.getAccessToken();
    return dataSource.startSession(accessToken, sessionId);
  }

  @override
  Future<LaunchedSession> stopCourse(int sessionId) async {
    var accessToken = await tokenStorage.getAccessToken();
    return dataSource.stopSession(accessToken, sessionId);
  }
}
