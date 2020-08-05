import 'package:flutter/material.dart';
import 'data_models/item_prototype.dart';

//Effective logical framerate.
const double kStepTime = 0.015;
//Rate (item/sec) of item generation
const double kItemGenertatorTime = 2.5;

//Tracks the filepaths to all sprites and their associated IDs
List<ItemPrototype> kAllItemPrototypes = [
  ItemPrototype(itemID: 'A1', imgFilepath: 'orange_orange.png'),
  ItemPrototype(itemID: 'A2', imgFilepath: 'apple_red.png'),
  ItemPrototype(itemID: 'A3', imgFilepath: 'berry_red.png'),
  ItemPrototype(itemID: 'A4', imgFilepath: 'cake_normal.png'),
  ItemPrototype(itemID: 'A5', imgFilepath: 'apple_blue.png'),
  ItemPrototype(itemID: 'A6', imgFilepath: 'pear_green.png'),
  ItemPrototype(itemID: 'A7', imgFilepath: 'pizza_normal.png'),
];

//Tracks how much sprites should be scaled up by default
const Map<String, double> kSpriteScaleFactor = {
  'A1': 2,
  'A2': 2.3,
  'A3': 2.5,
  'A4': 2,
  'A5': 2,
  'A6': 2,
  'A7': 2,
};

const TextStyle kLargeTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontFamily: 'Press Start 2P',
);

//Tracks the sprite to use to render the conveyor
const String kConveyorAssetPath = 'conveyor_tile_brown.png';

//
const double yPos = 180;
