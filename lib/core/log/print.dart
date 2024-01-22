import 'package:yoga_training_app/core/config/environment_config.dart';

void printInternal(value) {
  if (EnvironmentConfig.isDevelopment()) print(value);
}
