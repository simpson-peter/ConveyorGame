import 'package:flame/util.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class GameData extends ChangeNotifier {
  //Tracks the current language pack in use. Note that this is case-sensitive and most correspond exactly to the
  Language language = Language.LADIN;

  Util flameUtil;
  Size screenSize = Size(0, 0);
  int streak = 0;
  int correctTaps = 0;
  int incorrectTaps = 0;

  //Default y position for conveyor items
  static const double yPos = 180;

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
