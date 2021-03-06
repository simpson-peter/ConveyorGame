/*
* Represent the position, status, and visual representation of a conveyor item
*/
import 'dart:ui';
import 'package:fallingthings/ItemGenerator.dart';
import 'package:fallingthings/conveyor_game.dart';
import 'package:fallingthings/data_models/item_prototype.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

import 'data_models/game_data.dart';

class Item extends PositionComponent with Tapable {
  double xPos;
  double yPos;
  double height;
  double width;
  static double iconWidth = 75;
  String imgFilepath;
  Sprite image;

  //Tracks the sprite prototype from which this one is drawn.
  ItemPrototype prototype;

  //Item Constructor, all fields are mandatory.
  Item(
      {this.height = 75,
      @required this.prototype,
      this.width = 75,
      this.xPos = 0,
      this.yPos = GameData.yPos,
      this.imgFilepath}) {
    this.image = Sprite(prototype.imgFilepath);
    this.height = 75;
    this.width = 75;
  }

  //Draws the object on the canvas
  void render(Canvas canvas) {
    image.renderScaled(canvas, Position(xPos, yPos),
        scale: prototype.scaleFactor);
  }

  void onTapUp(TapUpDetails details) {
    debugPrint("Square Tapped");
  }

  void update(double dt) {}

  void playSound() {
    ConveyorGame.audio.play(prototype.audioFilepath);
  }

  //Returns whether the tap represented by td hit this square
  bool isTapped(TapDownDetails td) {
    //Check for x coordinate matching
    if (td.globalPosition.dx >= xPos &&
        td.globalPosition.dx <= (xPos + width)) {
      return (td.globalPosition.dy >= yPos &&
          td.globalPosition.dy <= (yPos + height));
    }

    return false;
  }
}
