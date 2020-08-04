import 'package:flame/util.dart';
import 'package:flutter/material.dart';

class GameData extends ChangeNotifier {
  int score = 0;
  Util flameUtil;
  Size screenSize = Size(0, 0);
  int streak = 0;

  GameData({Util flameUtil}) {
    this.flameUtil = flameUtil;
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
}
