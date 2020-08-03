import 'data_models/item.dart';
import 'dart:math';
import 'package:flutter/material.dart';

class ItemGenerator {
  //Tracks when to begin counting item production.
  int _startTime;

  //Random number generator to generate apple positions, seed with the time
  Random _rand;

  //Tracks the elapsed time since the last newItem request (secs)
  double _timeSinceLast = 0;
  //length of time between item generation (secs)
  double _productionInterval = 1;
  //List of Items from which to generate
  List<Item> items;

  static List<Color> testItemColors = [
    Colors.yellow,
    Colors.red,
    Colors.blue,
    Colors.greenAccent,
  ];

  //Position to initialize xpositions
  double yPos;

  ItemGenerator({this.items, @required this.yPos}) {
    _startTime = DateTime.now().millisecond;
    _rand = Random(_startTime);
  }

  void setItems(List<Item> items) {
    this.items = items;
  }

  //Generates a random element from items when appropriate.
  // Assumes that items is non-null and non-empty.
  void getNewItem(List<Item> toAddTo) {
    //Calculates the time since we last entered this method, add it to time since last item was produced
    _timeSinceLast += (DateTime.now().millisecond - _startTime);

    //If the elapsed time is over the threshold, we should produce an item
    if (_timeSinceLast >= _productionInterval) {
      _timeSinceLast = 0;
      toAddTo.add(
        Item(
          xPos: 0,
          yPos: this.yPos,
          itemColor: testItemColors[_rand.nextInt(testItemColors.length)],
        ),
      );
    }
  }
}
