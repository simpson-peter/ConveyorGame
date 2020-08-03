import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'GameShell.dart';
import 'data_models/game_data.dart';

//TODO Look at Snek main() if this doesn't work
void main() {
  //Run the game widget
  runApp(MyApp());

  //initialize flame Util object
  Util flameUtil = Util();
  //make app full screen, lock vertical orientation
  flameUtil.fullScreen();
  //TODO Allow landscape switching?
  flameUtil.setOrientation(DeviceOrientation.landscapeLeft);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        GameData();
      },
      child: MaterialApp(
        home: GameShell(),
      ),
    );
  }
}
