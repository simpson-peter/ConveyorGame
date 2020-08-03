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
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //initialize flame Util object
    Util flameUtil = Util();
    //make app full screen, lock vertical orientation
    flameUtil.fullScreen();
    //TODO Allow landscape switching?
    flameUtil.setOrientation(DeviceOrientation.landscapeLeft);

    return ChangeNotifierProvider(
      create: (context) {
        GameData(flameUtil: flameUtil);
      },
      child: MaterialApp(
        home: GameShell(),
      ),
    );
  }
}
