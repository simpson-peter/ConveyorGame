/*
* Represent the position, status, and visual representation of a conveyor item
*/
import 'dart:ui';
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
  Color itemColor;
  String imgFilepath;
  Sprite image;

  //Item Constructor, all fields are mandatory.
  Item(
      {this.width = 50,
      this.height = 50,
      @required this.itemColor,
      @required this.imgFilepath,
      this.xPos = 0,
      this.yPos}) {
    image = new Sprite(imgFilepath);
  }

  void onTapDown(TapDownDetails details) {
    itemColor = Colors.white;
    debugPrint("Square Tapped");
  }

  //Draws the object on the canvas
  void render(Canvas canvas) {
//    Rect itemRect = Rect.fromLTWH(xPos, yPos, width, height);
//    Paint itemPaint = Paint();
//    itemPaint.color = itemColor;
//    canvas.drawRect(itemRect, itemPaint);

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
