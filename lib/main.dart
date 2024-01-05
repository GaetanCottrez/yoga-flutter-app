import 'package:flutter/material.dart';
import 'bootstrap-app.dart';
import 'config/base_url_config.dart';
import 'config/environment_config.dart';

void main() {
  EnvironmentConfig(
      environment: Environment.PRODUCTION,
      baseUrl: BaseUrlConfig().baseUrlProduction);
  runApp(MyApp());
}
