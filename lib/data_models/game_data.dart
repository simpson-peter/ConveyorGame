import 'package:flame/util.dart';
import 'package:flutter/material.dart';

class GameData extends ChangeNotifier {
  int score = 0;
  Util _flameUtil;

  GameData({Util flameUtil}) {
    this._flameUtil = flameUtil;
  }

  void setUtil(Util util) {
    _flameUtil = util;
    notifyListeners();
  }

  Util getUtil() {
    return _flameUtil;
  }
}
