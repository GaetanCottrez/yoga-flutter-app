import 'package:flutter/material.dart';

import 'bootstrap-app.dart';
import 'core/config/base_url_config.dart';
import 'core/config/environment_config.dart';

void main() {
  EnvironmentConfig(
      environment: Environment.PRODUCTION,
      baseUrl: BaseUrlConfig().baseUrlProduction);
  runApp(const MyApp());
}
