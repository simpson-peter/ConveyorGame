import 'package:fallingthings/data_models/game_data.dart';
import 'package:fallingthings/widgets/game_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'conveyor_game.dart';

class GameShell extends StatefulWidget {
  @override
  _GameShellState createState() => _GameShellState();
}

class _GameShellState extends State<GameShell> {
  @override
  Widget build(BuildContext context) {
    ConveyorGame conveyorGame = ConveyorGame(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(child: conveyorGame.widget),
          GameBar(),
        ],
      ),
    );
  }
}
