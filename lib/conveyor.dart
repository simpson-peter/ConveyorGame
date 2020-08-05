import 'dart:ui';
import 'package:fallingthings/constants.dart';
import 'package:flame/components/component.dart';
import 'package:flame/game.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';

import 'data_models/game_data.dart';

class Conveyor extends PositionComponent {
  double screenWidth;
  Sprite image;

  //Tracks the rate at which the conveyor positions update
  double conveyorStepTime = kStepTime;

  //Tracks the time elapsed since the conveyor was last rendered
  double timeSinceConveyorUpdate = 0;

  static double tileWidth = 150;

  List<double> tileXPositions = List<double>();

  Conveyor({@required this.screenWidth}) {
    this.image = new Sprite(kConveyorAssetPath);
  }

  void updateScreenWidth(double newWidth) {
    this.screenWidth = newWidth;

    tileXPositions.add(-tileWidth);
    //intialize the tileXPositions appropriately based on the new screen length
    double renderTileStartXPos = 0;
    while (renderTileStartXPos < screenWidth) {
      tileXPositions.add(renderTileStartXPos);
      renderTileStartXPos += tileWidth;
    }
  }

  void update(double dt) {
    timeSinceConveyorUpdate += dt;
    if (timeSinceConveyorUpdate >= conveyorStepTime) {
      timeSinceConveyorUpdate = 0;
      for (int i = 0; i < tileXPositions.length; i++) {
        if (tileXPositions[i] > screenWidth) {
          tileXPositions.removeAt(i);
          tileXPositions.add(-tileWidth);
        } else {
          tileXPositions[i]++;
        }
      }
    }
  }

  @override
  void render(Canvas c) {
    //Tracks how much of the screen length we've rendered already
    for (double xPos in tileXPositions) {
      image.renderScaled(c, Position(xPos, GameData.yPos), scale: 1.0);
      //image.renderPosition(c, Position(xPos, yPos));
    }
  }
}
