import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_training_app/core/constants/constants.dart';
import 'package:yoga_training_app/domain/entities/pose.dart';

import 'WorkOut.dart';

class BreakTime extends StatelessWidget {
  List<Pose> poses;
  int poseIndex;

  BreakTime({
    required this.poses,
    required this.poseIndex,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerModelSec>(
        create: (context) => TimerModelSec(context, poses, poseIndex),
        child: Consumer<TimerModelSec>(builder: (context, myModel, mychild) {
          return WillPopScope(
            onWillPop: () async {
              myModel.show();
              return false;
            },
            child: Scaffold(
                backgroundColor: primary,
                body: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          const Text(
                            "Break Time",
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: white),
                          ),
                          Consumer<TimerModelSec>(
                            builder: (context, myModel, child) {
                              return Text(
                                myModel.countdown.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 65,
                                    color: white),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Consumer<TimerModelSec>(
                            builder: (context, myModel, child) {
                              return ElevatedButton(
                                  onPressed: () {
                                    myModel.skip();
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      child: const Text(
                                        "Sauter",
                                        style: TextStyle(fontSize: 20),
                                      )));
                            },
                          ),
                          const Spacer(),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
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
                                                  const Duration(seconds: 1));
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BreakTime(
                                                              poses: poses,
                                                              poseIndex:
                                                                  poseIndex -
                                                                      1)));
                                              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WorkOutDet(poses: poses, poseIndex: poseIndex-1)));
                                            },
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 15),
                                                child: const Text(
                                                  "Précédent",
                                                  style:
                                                      TextStyle(fontSize: 20),
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
                                                  const Duration(seconds: 1));
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BreakTime(
                                                              poses: poses,
                                                              poseIndex:
                                                                  poseIndex +
                                                                      1)));
                                              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WorkOutDet(poses: poses, poseIndex: poseIndex+1)));
                                            },
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 15),
                                                child: const Text(
                                                  "Suivant",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                )));
                                      })
                                    : Container()
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Text(
                                  "Suivant: ${poseIndex >= poses.length - 1 ? "Terminer" : poses[poseIndex].english_name}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: white),
                                ),
                              )),
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
                                    style:
                                        TextStyle(fontSize: 13, color: white),
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
                                          "Quitter",
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
                                        backgroundColor:
                                            MaterialStateProperty.all(white)),
                                  )
                                ],
                              ),
                            ));
                      },
                    )
                  ],
                )),
          );
        }));
  }
}

class TimerModelSec with ChangeNotifier {
  TimerModelSec(context, List<Pose> poses, int poseIndex) {
    MyTimerSec(context, poses, poseIndex);
  }

  int countdown = 10;
  bool isPassed = false;
  bool visible = false;
  bool Isskip = false;

  MyTimerSec(context, List<Pose> poses, int poseIndex) async {
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
