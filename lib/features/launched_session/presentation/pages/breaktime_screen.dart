import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_training_app/domain/entities/pose.dart';
import 'package:yoga_training_app/features/launched_session/presentation/widgets/breaktime_widget.dart';
import 'package:yoga_training_app/features/launched_session/presentation/widgets/workout_widget.dart';

class BreakTimeScreen extends StatelessWidget {
  List<Pose> poses;
  int poseIndex;
  String courseName;
  int courseId;

  BreakTimeScreen({
    required this.poses,
    required this.poseIndex,
    required this.courseName,
    required this.courseId,
  });

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

class BreaktimeTimerModelSec with ChangeNotifier {
  BreaktimeTimerModelSec(context, List<Pose> poses, int poseIndex,
      String courseName, int courseId) {
    MyTimerSec(context, poses, poseIndex, courseName, courseId);
  }

  int countdown = 10;
  bool isPassed = false;
  bool visible = false;
  bool Isskip = false;

  MyTimerSec(context, List<Pose> poses, int poseIndex, String courseName,
      int courseId) async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      visible ? countdown + 0 : countdown--;
      notifyListeners();
      if (countdown == 0 || Isskip) {
        timer.cancel();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => WorkOut(
                      poses: poses,
                      poseIndex: poseIndex,
                      courseId: courseId,
                      courseName: courseName,
                    )));
      } else if (isPassed) {
        timer.cancel();
      }
    });
  }

  void skip() {
    Isskip = true;
    notifyListeners();
  }

  void show() {
    visible = true;
    notifyListeners();
  }

  void hide() {
    visible = false;
    notifyListeners();
  }

  void Pass() {
    isPassed = true;
    notifyListeners();
  }
}
