import 'package:fallingthings/data_models/item_prototype.dart';

import 'data_models/item.dart';
import 'dart:math';
import 'package:flutter/material.dart';

class ItemGenerator {
  //Tracks when to begin counting item production.
  int _startTime;

  //Random number generator to generate apple positions, seed with the time
  Random _rand;

  //Tracks the time at the last item generation
  int _timeAtLast;
  //length of time between item generation (secs)
  double _productionInterval = 3000;
  //List of Items from which to generate
  List<ItemPrototype> items;

  List<ItemPrototype> _allItemPrototypes = [
    ItemPrototype(itemID: 'A1', imgFilepath: 'orange_orange.png'),
    ItemPrototype(itemID: 'A2', imgFilepath: 'apple_red.png'),
    ItemPrototype(itemID: 'A3', imgFilepath: 'berry_red.png'),
    ItemPrototype(itemID: 'A4', imgFilepath: 'cake_normal.png'),
  ];

  //Position to initialize y positions
  double yPos;

  ItemGenerator({this.items, @required this.yPos}) {
    _startTime = DateTime.now().millisecondsSinceEpoch;
    _rand = Random(_startTime);
    _timeAtLast = _startTime;
  }

  void setItems(List<ItemPrototype> items) {
    this.items = items;
  }

  //Generates a random element from items when appropriate.
  // Assumes that items is non-null and non-empty.
  void getNewItem(List<Item> toAddTo) {
    //If the elapsed time is over the threshold, we should produce an item
    toAddTo.add(
      Item(
        xPos: 0,
        yPos: 200,
        prototype: _allItemPrototypes[_rand.nextInt(_allItemPrototypes.length)],
      ),
    );
  }
}
