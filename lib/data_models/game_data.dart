import 'package:flame/util.dart';
import 'package:flutter/material.dart';

class GameData extends ChangeNotifier {
  Util flameUtil;
  Size screenSize = Size(0, 0);
  int streak = 0;
  int correctTaps = 0;
  int incorrectTaps = 0;

  GameData({Util flameUtil}) {
    this.flameUtil = flameUtil;
  }

  void incrementCorrectTaps() {
    correctTaps++;
    notifyListeners();
  }

  void incrementIncorrectTaps() {
    incorrectTaps++;
    notifyListeners();
  }

  void incrementStreak() {
    streak++;
    notifyListeners();
  }

  void setStreak(int newStreak) {
    this.streak = newStreak;
    notifyListeners();
  }

  void setScreenSize(Size screenSize) {
    this.screenSize = screenSize;
    notifyListeners();
  }

  void setUtil(Util util) {
    flameUtil = util;
    notifyListeners();
  }

  double getScore() {
    if (correctTaps == 0) {
      return 0;
    } else {
      return correctTaps / (correctTaps + incorrectTaps);
    }
  }

  void resetScore() {
    this.correctTaps = 0;
    this.incorrectTaps = 0;
    notifyListeners();
  }
}
