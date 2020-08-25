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

  @override
  void render(Canvas c) {
    //TODO Delete
    debugPrint('In RES render()');
    Size screenSize = Provider.of<GameData>(context, listen: false).screenSize;
    emote.renderScaled(c, Position(0, 0));
  }
}
