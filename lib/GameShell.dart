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
    return fallingGame.widget;
  }
}
