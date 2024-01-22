import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_training_app/core/config/constant_config.dart';
import 'package:yoga_training_app/domain/entities/pose.dart';
import 'package:yoga_training_app/features/launched_session/presentation/manager/timer_model_sec.dart';
import 'package:yoga_training_app/features/launched_session/presentation/pages/breaktime_screen.dart';
import 'package:yoga_training_app/features/launched_session/presentation/pages/finish_screen.dart';
import 'package:yoga_training_app/features/launched_session/presentation/widgets/workout_widget.dart';

class WorkOutScreen extends StatelessWidget {
  final List<Pose> poses;
  final int poseIndex;
  final String courseName;
  final int courseId;

  final int durationPose = ConstantConfig().durationPose;

  WorkOutScreen({
    Key? key,
    required this.poses,
    required this.poseIndex,
    required this.courseName,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workOutTimerModel = WorkOutTimerModelSec(
      context,
      poses,
      poseIndex + 1,
      durationPose,
      courseName,
      courseId,
    );

    return ChangeNotifierProvider<WorkOutTimerModelSec>.value(
      value: workOutTimerModel,
      child: Consumer<WorkOutTimerModelSec>(builder: (context, myModel, child) {
        return WillPopScope(
          onWillPop: () async {
            myModel.show();
            return false;
          },
          child: WorkOutWidget(
            poses: poses,
            poseIndex: poseIndex,
            courseName: courseName,
            courseId: courseId,
          ),
        );
      }),
    );
  }
}

class WorkOutTimerModelSec extends AbstractTimerModelSec {
  WorkOutTimerModelSec(context, List<Pose> poses, int poseIndex, int countdown,
      String courseName, int courseId) {
    setCDownValue(countdown);
    CheckIfLast(poseIndex >= poses.length - 1);
    initializeTimer(context, poses, poseIndex, courseName, courseId);
  }

  @override
  int countdown = 0;
  bool isLast = false;
  bool isDisposed = false;

  void CheckIfLast(bool Ans) {
    isLast = Ans;
  }

  void setCDownValue(int count) {
    countdown = count;
  }

  @override
  bool visible = false;
  @override
  bool isPassed = false;
  Timer? _timer;

  void initializeTimer(
    BuildContext context,
    List<Pose> poses,
    int poseIndex,
    String courseName,
    int courseId,
  ) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isDisposed) {
        visible ? countdown + 0 : countdown--;
        notifyListeners();
        if (countdown == 0) {
          _timer?.cancel();
          if (isLast) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FinishScreen(
                  courseId: courseId,
                  courseName: courseName,
                ),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BreakTimeScreen(
                  poses: poses,
                  poseIndex: poseIndex,
                  courseId: courseId,
                  courseName: courseName,
                ),
              ),
            );
          }
        } else if (isPassed) {
          _timer?.cancel();
        }
      }
    });
  }

  void didDispose() {
    isDisposed = true;
  }

  @override
  void dispose() {
    _timer?.cancel();
    didDispose();
    super.dispose();
  }
}
