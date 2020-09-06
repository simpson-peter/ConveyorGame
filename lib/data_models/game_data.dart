import 'package:flame/position.dart';
import 'package:flame/util.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class GameData extends ChangeNotifier {
  //Tracks the current language pack in use. Note that this is case-sensitive and most correspond exactly to the
  Language language = Language.LADIN;

  Util flameUtil;
  Size _screenSize = Size(0, 0);
  int streak = 0;
  int correctTaps = 0;
  int incorrectTaps = 0;

  Function getSize;

  //Default y position for conveyor items
  static const double yPos = 180;

  GameData({Util flameUtil, this.getSize}) {
    this.flameUtil = flameUtil;
  }

  Size getScreenSize() {
    Size returnedSize = getSize();
    if (returnedSize != null) {
      _screenSize = returnedSize;
    }

    return _screenSize;
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
    this._screenSize = screenSize;
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
