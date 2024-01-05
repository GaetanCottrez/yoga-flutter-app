enum Environment {
  DEVELOPMENT,
  PRODUCTION,
}

class EnvironmentConfig {
  static final EnvironmentConfig _instance = EnvironmentConfig._internal();

  EnvironmentConfig._internal();

  factory EnvironmentConfig({
    required Environment environment,
    required String baseUrl,
  }) {
    _instance.environment = environment;
    _instance.baseUrl = baseUrl;
    return _instance;
  }

  Environment environment = Environment.DEVELOPMENT;
  String baseUrl = '';

  static String getBaseUrl() => _instance.baseUrl;

  static bool isProduction() => _instance.environment == Environment.PRODUCTION;

  static bool isDevelopment() =>
      _instance.environment == Environment.DEVELOPMENT;
}
