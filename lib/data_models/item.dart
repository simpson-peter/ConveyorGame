/*
* Represent the position, status, and visual representation of a conveyor item
*/
import 'dart:ui';
import 'package:flutter/material.dart';

class Item {
  double xPos;
  double yPos;
  double height;
  double width;
  Color itemColor;

  //Item Constructor, all fields are mandatory.
  Item(
      {@required this.width,
      @required this.height,
      @required this.itemColor,
      @required this.xPos,
      @required this.yPos});

  //Draws the object on the canvas
  void render(Canvas canvas) {
    Rect itemRect = Rect.fromLTWH(xPos, yPos, width, height);
    Paint itemPaint = Paint();
    itemPaint.color = itemColor;
    canvas.drawRect(itemRect, itemPaint);
  }
}
