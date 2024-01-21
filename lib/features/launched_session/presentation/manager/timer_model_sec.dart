import 'package:flutter/material.dart';
import 'package:yoga_training_app/domain/entities/pose.dart';

abstract class AbstractTimerModelSec with ChangeNotifier {
  abstract int countdown;
  bool isPassed = false;
  bool visible = false;
  bool Isskip = false;

  MyTimerSec(context, List<Pose> poses, int poseIndex, String courseName,
      int courseId) async {}

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
