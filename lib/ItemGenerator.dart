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
  List<Item> items;

  static List<Color> testItemColors = [
    Colors.yellow,
    Colors.red,
    Colors.blue,
    Colors.greenAccent,
    Colors.pink,
    Colors.orangeAccent,
    Colors.purpleAccent,
  ];

  //Position to initialize y positions
  double yPos;

  ItemGenerator({this.items, @required this.yPos}) {
    _startTime = DateTime.now().millisecondsSinceEpoch;
    _rand = Random(_startTime);
    _timeAtLast = _startTime;
  }

  void setItems(List<Item> items) {
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
        itemColor: testItemColors[_rand.nextInt(testItemColors.length)],
      ),
    );
  }
}
