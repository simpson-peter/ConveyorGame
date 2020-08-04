//Represents the abstract information for a class of item. The blueprint from which to make classes of this kind
import 'package:fallingthings/constants.dart';
import 'package:flutter/material.dart';

class ItemPrototype {
  //Alphanumeric ID starting from A0, A1, A2.... Z9.
  String itemID;
  //Path the to item asset image path relative to assets/images/
  String imgFilepath;

  //Map which tracks how much to scale each sprite
  static Map<String, double> itemScaleFactor = Map<String, double>();

  //Tracks how much to scale each sprite
  double scaleFactor;

  ItemPrototype({@required this.itemID, @required this.imgFilepath}) {
    this.scaleFactor = kSpriteScaleFactor[this.itemID];
  }
}
