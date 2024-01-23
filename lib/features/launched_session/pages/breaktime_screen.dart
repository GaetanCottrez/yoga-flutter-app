import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_training_app/domain/entities/pose.dart';
import 'package:yoga_training_app/features/launched_session/manager/timer_model_sec.dart';
import 'package:yoga_training_app/features/launched_session/pages/workout_screen.dart';
import 'package:yoga_training_app/features/launched_session/widgets/breaktime_widget.dart';

class BreakTimeScreen extends StatelessWidget {
  final List<Pose> poses;
  final int poseIndex;
  final String courseName;
  final int courseId;

  const BreakTimeScreen({
    Key? key,
    required this.poses,
    required this.poseIndex,
    required this.courseName,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BreaktimeTimerModelSec>(
        create: (context) => BreaktimeTimerModelSec(
            context, poses, poseIndex, courseName, courseId),
        child: Consumer<BreaktimeTimerModelSec>(
            builder: (context, myModel, mychild) {
          return WillPopScope(
            onWillPop: () async {
              myModel.show();
              return false;
            },
            child: BreakTimeWidget(
                poses: poses,
                poseIndex: poseIndex,
                courseName: courseName,
                courseId: courseId),
          );
        }));
  }
}

class BreaktimeTimerModelSec extends AbstractTimerModelSec {
  Timer? _timer;

  BreaktimeTimerModelSec(context, List<Pose> poses, int poseIndex,
      String courseName, int courseId) {
    MyTimerSec(context, poses, poseIndex, courseName, courseId);
  }

  @override
  int countdown = 10;

  MyTimerSec(context, List<Pose> poses, int poseIndex, String courseName,
      int courseId) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      visible ? countdown + 0 : countdown--;
      notifyListeners();
      if (countdown == 0 || Isskip) {
        timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WorkOutScreen(
              poses: poses,
              poseIndex: poseIndex,
              courseId: courseId,
              courseName: courseName,
            ),
          ),
        );
      } else if (isPassed) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Annuler le minuteur avant de disposer du modèle
    super.dispose();
  }
}
