import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_training_app/features/home/data/models/course.dart';
import "dart:math";

import 'package:yoga_training_app/features/home/data/models/pose.dart';

import 'WorkOut.dart';

class LaunchedSession extends StatelessWidget {
  Course course;

  LaunchedSession({required this.course});

  T getRandomElement<T>(List<T> list) {
    final random = new Random();
    var i = random.nextInt(list.length);
    return list[i];
  }

  var list = [
    'Create a comfortable spot for your yoga practice',
    'Yoga can ease arthritis symptoms.',
    'Yoga benefits heart health.',
    'Yoga relaxes you, to help you sleep better.',
    'Yoga can mean more energy and brighter moods.',
    'Yoga helps you manage stress.'
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerModel>(
      create: (context) => TimerModel(context, poses: course.poses),
      child: Scaffold(
        body: Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2 - 100,
                ),
                Text(
                  "ARE YOU READY?",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40,
                ),
                Consumer<TimerModel>(builder: (context, myModel, child) {
                  return Text(
                    myModel.countdown.toString(),
                    style: TextStyle(fontSize: 48),
                  );
                }),
                Spacer(),
                Divider(
                  thickness: 2,
                ),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Text(
                        "Tip: " + getRandomElement(list),
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TimerModel with ChangeNotifier {
  List<Pose> poses;

  TimerModel(context, {required this.poses}) {
    MyTimer(context);
  }

  int countdown = 5;

  MyTimer(context) async {
    Timer.periodic(Duration(seconds: 1), (timer) {
      countdown--;
      if (countdown == 0) {
        timer.cancel();
        timer.cancel();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => WorkOut(
                      poses: poses,
                      poseIndex: 0,
                    )));
      }
      notifyListeners();
    });
  }
}