import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data_models/game_data.dart';

class RoundEndScreen extends PositionComponent {
  BuildContext context;
  Sprite emote;
  String filepath;
  double score;

  //Calculates how much to magnify the emote by
  static double emoteScale = 15;

  //Uses score to calculate the emote to be shown.
  RoundEndScreen({@required this.context}) {
    score = Provider.of<GameData>(context, listen: false).getScore();

    //determine, based on score, which emote to display
    if (score == 1) {
      filepath = 'veryhappy.png';
    } else if (score > 0.8) {
      filepath = 'happy.png';
    } else if (score > 0.4) {
      filepath = 'meh.png';
    } else {
      filepath = 'meh.png';
    }

    this.emote = Sprite(filepath);
  }

  //Displays the emote in the middle of the screen
  @override
  void render(Canvas c) {
    Size screenSize =
        Provider.of<GameData>(context, listen: false).getScreenSize();

    //Calculate the center of the screen
    Position centerPos;
//    if(screenSize != null){
    centerPos = Position(
      (screenSize.width / 2) - (emote.size.x * emoteScale) / 2,
      (screenSize.height / 2) - (emote.size.y * emoteScale) / 2,
    );
//    }

    emote.renderScaled(c, centerPos, scale: emoteScale);
  }
}
