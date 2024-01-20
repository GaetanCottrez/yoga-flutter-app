import 'package:yoga_training_app/domain/entities/launched-session.dart';

abstract class ILaunchedSessionDataSource {
  Future<LaunchedSession?> activeSession(String accessToken);

  Future<LaunchedSession> startSession(String accessToken, int sessionId);

  Future<LaunchedSession> stopSession(String accessToken, int sessionId);
}
