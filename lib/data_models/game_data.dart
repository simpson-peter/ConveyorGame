import 'package:flame/util.dart';
import 'package:flutter/material.dart';

class GameData extends ChangeNotifier {
  int score = 0;
  Util flameUtil;
  Size screenSize;

  GameData({Util flameUtil}) {
    this.flameUtil = flameUtil;
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
