/*
* Represent the position, status, and visual representation of a conveyor item
*/
import 'dart:ui';
import 'package:fallingthings/ItemGenerator.dart';
import 'package:fallingthings/data_models/item_prototype.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class Item extends PositionComponent with Tapable {
  double xPos;
  double yPos;
  double height;
  double width;
  static double iconWidth = 50;
  String imgFilepath;
  Sprite image;

  //Tracks the sprite prototype from which this one is drawn.
  ItemPrototype prototype;

  //Item Constructor, all fields are mandatory.
  Item(
      {this.height = 50,
      @required this.prototype,
      this.xPos = 100,
      this.yPos = 100,
      this.imgFilepath}) {
    this.image = new Sprite(prototype.imgFilepath);
    this.width = iconWidth;
  }

  //Draws the object on the canvas
  void render(Canvas canvas) {
    image.renderScaled(canvas, Position(xPos, yPos), scale: 2.0);
  }

  void onTapUp(TapUpDetails details) {
    debugPrint("Square Tapped");
  }

  void update(double dt) {}

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
