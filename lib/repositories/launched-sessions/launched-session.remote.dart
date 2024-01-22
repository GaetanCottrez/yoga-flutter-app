import 'dart:convert';

import 'package:http/http.dart';
import 'package:yoga_training_app/core/config/environment_config.dart';
import 'package:yoga_training_app/core/error/exception.dart';
import 'package:yoga_training_app/core/log/print.dart';
import 'package:yoga_training_app/domain/data-sources/launched-session.data-source.dart';
import 'package:yoga_training_app/domain/entities/launched-session.dart';
import 'package:yoga_training_app/repositories/courses/course.remote.dart';

class LaunchedSessionRemoteDataSource implements ILaunchedSessionDataSource {
  @override
  Future<LaunchedSession?> activeSession(String accessToken) async {
    LaunchedSession? launchedSession;
    try {
      printInternal(
          Uri.parse('${EnvironmentConfig.getBaseUrl()}user/session/active'));
      Response response = await get(
        Uri.parse('${EnvironmentConfig.getBaseUrl()}user/session/active'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        launchedSession = LaunchedSession(
            start_date: DateTime.parse(data['start_date']),
            end_date: data['end_date'] != null
                ? DateTime.parse(data['end_date'])
                : null,
            session: CourseRemoteDataSource.convertJSONCourse(data['session']));
      } else if (response.statusCode == 401) {
        throw UnauthorizedException();
      } else {
        printInternal('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      printInternal(e.toString());
    }
    return launchedSession;
  }

  @override
  Future<LaunchedSession> startSession(
      String accessToken, int sessionId) async {
    return await startOrStopSession(accessToken, sessionId, 'start');
  }

  @override
  Future<LaunchedSession> stopSession(String accessToken, int sessionId) async {
    return await startOrStopSession(accessToken, sessionId, 'stop');
  }

  Future<LaunchedSession> startOrStopSession(
      String accessToken, int sessionId, String endpoint) async {
    LaunchedSession launchedSession = LaunchedSession(
        start_date: DateTime.now(), end_date: null, session: null);
    try {
      printInternal(
          '${EnvironmentConfig.getBaseUrl()}session/$sessionId/$endpoint');
      Response response = await post(
        Uri.parse(
            '${EnvironmentConfig.getBaseUrl()}session/$sessionId/$endpoint'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        launchedSession = LaunchedSession(
            start_date: DateTime.parse(data['start_date']),
            end_date: data['end_date'] != null
                ? DateTime.parse(data['end_date'])
                : null,
            session: CourseRemoteDataSource.convertJSONCourse(data['session']));
      } else if (response.statusCode == 401) {
        throw UnauthorizedException();
      } else {
        printInternal('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      printInternal(e.toString());
    }
    return launchedSession;
  }
}
