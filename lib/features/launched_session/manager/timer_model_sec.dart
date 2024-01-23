import 'package:flutter/material.dart';

abstract class AbstractTimerModelSec with ChangeNotifier {
  abstract int countdown;
  bool isPassed = false;
  bool visible = false;
  bool Isskip = false;

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
