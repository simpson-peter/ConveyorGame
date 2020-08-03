import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'conveyor_game.dart';

class GameShell extends StatefulWidget {
  @override
  _GameShellState createState() => _GameShellState();
}

class _GameShellState extends State<GameShell> {
  @override
  Widget build(BuildContext context) {
    ConveyorGame fallingGame = ConveyorGame();
    TapGestureRecognizer tapper = TapGestureRecognizer();
    tapper.onTapDown = fallingGame.onTapDown;
    fl
    return fallingGame.widget;
  }
}
