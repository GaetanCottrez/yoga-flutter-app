import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_training_app/core/config/constant_config.dart';
import 'package:yoga_training_app/domain/entities/course.dart';
import 'package:yoga_training_app/domain/entities/pose.dart';
import 'package:yoga_training_app/domain/use-cases/start_launched_session.dart';
import 'package:yoga_training_app/features/launched_session/pages/workout_screen.dart';
import 'package:yoga_training_app/features/launched_session/provider/tips.provider.dart';
import 'package:yoga_training_app/features/launched_session/widgets/launched_session_widget.dart';
import 'package:yoga_training_app/injections/course.injection.dart';

class LaunchedSessionScreen extends StatelessWidget {
  final Course course;
  final StartLaunchedSessionUseCase startLaunchedSessionUseCase;
  TipsProvider tipsProvider;

  LaunchedSessionScreen({
    Key? key,
    required this.course,
    TipsProvider? tipsProvider,
    StartLaunchedSessionUseCase? startLaunchedSessionUseCase,
  })  : tipsProvider = tipsProvider ?? TipsProvider(),
        startLaunchedSessionUseCase = startLaunchedSessionUseCase ??
            InjectionContainer.provideStartLaunchedSessionUseCase(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LaunchedSessionTimerModel(course: course, context: context)
        ..initializeTimer(),
      child: LaunchedSessionWidget(
        course: course,
        startLaunchedSessionUseCase: startLaunchedSessionUseCase,
        tipsProvider: tipsProvider,
      ),
    );
  }
}

class LaunchedSessionTimerModel with ChangeNotifier {
  final Course course;
  final BuildContext context;
  int countdown = 5;
  Timer? _timer;

  LaunchedSessionTimerModel({required this.course, required this.context});

  void initializeTimer() {
    List<Pose> poses =
        Course.MakeThisSession(course, ConstantConfig().durationPose);
    _timer = Timer.periodic(
        const Duration(seconds: 1), (timer) => _timerTick(timer, poses));
  }

  void _timerTick(Timer timer, List<Pose> poses) {
    countdown--;
    if (countdown == 0) {
      _navigateToWorkoutScreen(poses);
      timer.cancel();
    }
    notifyListeners();
  }

  void _navigateToWorkoutScreen(List<Pose> poses) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => WorkOutScreen(
          poses: poses,
          courseName: course.name,
          courseId: course.id,
          poseIndex: 0,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
