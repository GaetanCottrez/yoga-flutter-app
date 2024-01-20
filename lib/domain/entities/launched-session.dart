import 'package:yoga_training_app/domain/entities/course.dart';

class LaunchedSession {
  final DateTime start_date;
  final DateTime? end_date;
  final Course? session;

  LaunchedSession({
    required this.start_date,
    required this.end_date,
    required this.session,
  });
}
