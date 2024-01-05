import '../../config/environment_config.dart';

void printInternal(value) {
  if (EnvironmentConfig.isDevelopment()) print(value);
}
