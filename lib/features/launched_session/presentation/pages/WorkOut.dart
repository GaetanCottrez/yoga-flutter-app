import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_training_app/config/constant_config.dart';
import 'package:yoga_training_app/core/constants/constants.dart';
import 'package:yoga_training_app/core/db/localDb.dart';
import 'package:yoga_training_app/domain/entities/pose.dart';

import 'Break.dart';
import 'Finish.dart';

class WorkOut extends StatelessWidget {
  List<Pose> poses;
  int poseIndex;

  final int durationPose = ConstantConfig().durationPose;

  WorkOut({
    required this.poses,
    required this.poseIndex,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerModelSec>(
      create: (context) =>
          TimerModelSec(context, poses, poseIndex + 1, durationPose),
      child: Consumer<TimerModelSec>(builder: (context, myModel, child) {
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
                              Consumer<TimerModelSec>(
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
                      Consumer<TimerModelSec>(
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
                                ? Consumer<TimerModelSec>(
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
                                                      BreakTime(
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
                                ? Consumer<TimerModelSec>(
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
                                                      BreakTime(
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
                      Divider(
                        thickness: 2,
                      ),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Text(
                              "Suivant: ${poseIndex >= poses.length - 1 ? "Terminer" : poses[poseIndex + 1].english_name}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ))
                    ],
                  ),
                ),
                Consumer<TimerModelSec>(
                  builder: (context, myModel, child) {
                    return Visibility(
                        visible: myModel.visible,
                        child: Container(
                          color: primary.withOpacity(0.9),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Pause",
                                style: TextStyle(
                                    fontSize: 40,
                                    color: white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Yoga feels better",
                                style: TextStyle(fontSize: 13, color: white),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WorkOut(
                                                poses: poses,
                                                poseIndex: 0,
                                              )));
                                },
                                child: const SizedBox(
                                  width: 180,
                                  child: Text(
                                    "Redémarrer",
                                    style: TextStyle(color: white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              OutlinedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: 180,
                                    child: Text(
                                      "Arrêter",
                                      style: TextStyle(color: white),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                              OutlinedButton(
                                onPressed: () {
                                  myModel.hide();
                                },
                                child: Container(
                                  width: 180,
                                  child: const Text(
                                    "Continuer",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.white)),
                              )
                            ],
                          ),
                        ));
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

class TimerModelSec with ChangeNotifier {
  TimerModelSec(context, List<Pose> poses, int poseIndex, int countdown) {
    setCDownValue(countdown);
    CheckIfLast(poseIndex >= poses.length - 1);
    MyTimerSec(context, poses, poseIndex);
    ReadTime(poseIndex);
  }

  int countdown = 0;
  bool isLast = false;

  void ReadTime(int poseIndex) {
    print(poseIndex);
    if (poseIndex == 1) {
      String now = DateTime.now().toString();
      LocalDB.setStartTime(now);
    }
  }

  void CheckIfLast(bool Ans) {
    isLast = Ans;
  }

  void setCDownValue(int count) {
    countdown = count;
  }

  bool visible = false;
  bool isPassed = false;

  MyTimerSec(context, List<Pose> poses, int poseIndex) async {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      visible ? countdown + 0 : countdown--;
      notifyListeners();
      if (countdown == 0) {
        timer.cancel();
        isLast
            ? Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Finish()))
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        BreakTime(poses: poses, poseIndex: poseIndex)));
      } else if (isPassed) {
        timer.cancel();
      }
    });
  }

  void show() {
    visible = true;
    notifyListeners();
  }

  void Pass() {
    isPassed = true;
    notifyListeners();
  }

  void hide() {
    visible = false;
    notifyListeners();
  }
}
