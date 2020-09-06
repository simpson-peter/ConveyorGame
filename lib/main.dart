import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'game_shell.dart';
import 'data_models/game_data.dart';

//TODO Look at Snek main() if this doesn't work
void main() {
  //Run the game widget
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Size size;
  //Ensures that screen dimensions are loaded before proceeding to render the game.
  void loadDimensions() async {
    size = await Flame.util.initialDimensions();
  }

  //Function called by provider to load size data from surrounding context
  Size getSize() {
    return size;
  }

  @override
  Widget build(BuildContext context) {
    //initialize flame Util object
    Util flameUtil = Util();
    loadDimensions();
    //make app full screen, lock vertical orientation
    flameUtil.fullScreen();
    //TODO Allow landscape switching?
    flameUtil.setOrientation(DeviceOrientation.landscapeLeft);

    return ChangeNotifierProvider(
      create: (context) => GameData(
        flameUtil: flameUtil,
        getSize: getSize,
      ),
      child: MaterialApp(
        home: GameShell(),
      ),
    );
  }
}
