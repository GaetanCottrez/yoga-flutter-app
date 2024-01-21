import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_training_app/config/constant_config.dart';
import 'package:yoga_training_app/core/constants/constants.dart';
import 'package:yoga_training_app/domain/entities/pose.dart';
import 'package:yoga_training_app/features/launched_session/presentation/manager/timer_model_sec.dart';
import 'package:yoga_training_app/features/launched_session/presentation/pages/breaktime_screen.dart';
import 'package:yoga_training_app/features/launched_session/presentation/pages/finish_screen.dart';
import 'package:yoga_training_app/features/launched_session/presentation/widgets/bottom_divider_widget.dart';
import 'package:yoga_training_app/features/launched_session/presentation/widgets/next_pose_widget.dart';
import 'package:yoga_training_app/features/launched_session/presentation/widgets/pause_widget.dart';

class WorkOutScreen extends StatelessWidget {
  List<Pose> poses;
  int poseIndex;
  String courseName;
  int courseId;

  final int durationPose = ConstantConfig().durationPose;

  WorkOutScreen({
    required this.poses,
    required this.poseIndex,
    required this.courseName,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WorkOutTimerModelSec>(
      create: (context) => WorkOutTimerModelSec(
          context, poses, poseIndex + 1, durationPose, courseName, courseId),
      child: Consumer<WorkOutTimerModelSec>(builder: (context, myModel, child) {
        return WillPopScope(
          onWillPop: () async {
            myModel.show();
            return false;
          },
          child: Scaffold(
            body: Stack(
              children: [
                Container(
                  child: Column(
                    children: [
                      Image.network(poses[poseIndex].img_url_jpg),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          poses[poseIndex].english_name,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Spacer(),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 80),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                          decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(50)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "00",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: white),
                              ),
                              Text(
                                " : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: white),
                              ),
                              Consumer<WorkOutTimerModelSec>(
                                builder: (context, myModel, child) {
                                  return Text(
                                    myModel.countdown.toString().length == 1
                                        ? "0" + myModel.countdown.toString()
                                        : myModel.countdown.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: white),
                                  );
                                },
                              )
                            ],
                          )),
                      Spacer(),
                      SizedBox(
                        height: 30,
                      ),
                      Consumer<WorkOutTimerModelSec>(
                        builder: (context, myModel, child) {
                          return ElevatedButton(
                              onPressed: () {
                                myModel.show();
                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  child: const Text(
                                    "Pause",
                                    style: TextStyle(fontSize: 20),
                                  )));
                        },
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            poseIndex != 0
                                ? Consumer<WorkOutTimerModelSec>(
                                    builder: (context, myModel, child) {
                                    return ElevatedButton(
                                        onPressed: () async {
                                          myModel.Pass();
                                          await Future.delayed(
                                              Duration(seconds: 1));
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BreakTimeScreen(
                                                          courseId: courseId,
                                                          courseName:
                                                              courseName,
                                                          poses: poses,
                                                          poseIndex:
                                                              poseIndex - 1)));
                                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WorkOutDet(poses: poses, poseIndex: poseIndex-1)));
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 15),
                                            child: const Text(
                                              "Précédent",
                                              style: TextStyle(fontSize: 20),
                                            )));
                                  })
                                : Container(),
                            poseIndex != poses.length - 1
                                ? Consumer<WorkOutTimerModelSec>(
                                    builder: (context, myModel, child) {
                                    return ElevatedButton(
                                        onPressed: () async {
                                          myModel.Pass();
                                          await Future.delayed(
                                              Duration(seconds: 1));
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BreakTimeScreen(
                                                          courseId: courseId,
                                                          courseName:
                                                              courseName,
                                                          poses: poses,
                                                          poseIndex:
                                                              poseIndex + 1)));
                                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WorkOutDet(poses: poses, poseIndex: poseIndex+1)));
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 15),
                                            child: const Text(
                                              "Suivant",
                                              style: TextStyle(fontSize: 20),
                                            )));
                                  })
                                : Container()
                          ],
                        ),
                      ),
                      const BottomDivider(),
                      NextPoseText(poses: poses, poseIndex: poseIndex),
                    ],
                  ),
                ),
                Consumer<WorkOutTimerModelSec>(
                  builder: (context, myModel, child) {
                    return PauseOverlay(
                      isVisible: myModel.visible,
                      onRestart: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkOutScreen(
                              poses: poses,
                              poseIndex: 0,
                              courseId: courseId,
                              courseName: courseName,
                            ),
                          ),
                        );
                      },
                      onQuit: () => Navigator.pop(context),
                      onContinue: myModel.hide,
                    );
                  },
                )
              ],
            ),
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
    MyTimerSec(context, poses, poseIndex, courseName, courseId);
  }

  int countdown = 0;
  bool isLast = false;

  void CheckIfLast(bool Ans) {
    isLast = Ans;
  }

  void setCDownValue(int count) {
    countdown = count;
  }

  bool visible = false;
  bool isPassed = false;

  MyTimerSec(context, List<Pose> poses, int poseIndex, String courseName,
      int courseId) async {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      visible ? countdown + 0 : countdown--;
      notifyListeners();
      if (countdown == 0) {
        timer.cancel();
        isLast
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => FinishScreen(
                          courseId: courseId,
                          courseName: courseName,
                        )))
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => BreakTimeScreen(
                        poses: poses,
                        poseIndex: poseIndex,
                        courseId: courseId,
                        courseName: courseName)));
      } else if (isPassed) {
        timer.cancel();
      }
    });
  }
}
