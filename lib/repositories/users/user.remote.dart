import 'dart:convert';

import 'package:http/http.dart';
import 'package:yoga_training_app/core/config/environment_config.dart';
import 'package:yoga_training_app/core/error/exception.dart';
import 'package:yoga_training_app/core/log/print.dart';
import 'package:yoga_training_app/domain/data-sources/user.data-source.dart';
import 'package:yoga_training_app/domain/entities/statistics.dart';

class UserRemoteDataSource implements IUserDataSource {
  @override
  Future<StatsData> getStatistics(String accessToken) async {
    StatsData statsData = StatsData(
        totalLaunchedSessionCount: 0,
        averageSessionDuration: 0,
        mostPracticedPoses: []);
    try {
      Response response = await get(
        Uri.parse('${EnvironmentConfig.getBaseUrl()}user/statistics'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        statsData = StatsData.fromJson(data);
      } else if (response.statusCode == 401) {
        throw UnauthorizedException();
      } else {
        printInternal('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      printInternal(e.toString());
      rethrow;
    }
    return statsData;
  }
}
