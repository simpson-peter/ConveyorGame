import 'dart:ui';
import 'package:fallingthings/ItemGenerator.dart';
import 'package:flame/game/game.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'data_models/item.dart';

class ConveyorGame extends Game {
  Size screenSize;

  //double which tracks how long to wait between game state updates
  double _stepTime = kStepTime;
  //Keeps track of the time since the update loop last executed
  double _timeSinceStep = 0;

  List<Item> _items = List<Item>();

  ItemGenerator itemGenerator;

  //Constructor
  ConveyorGame() {
    _items.add(
      Item(
        height: 50,
        width: 50,
        itemColor: Colors.yellow,
        xPos: 0,
        yPos: 50,
      ),
    );
  }

  @override
  void render(Canvas canvas) {
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff000000);
    canvas.drawRect(bgRect, bgPaint);

    for (Item item in _items) {
      item.render(canvas);
    }
  }

  @override
  void update(double t) {
    //Create an item generator if it does not yet exist.
    if (itemGenerator == null) {
      itemGenerator = ItemGenerator(yPos: screenSize.height / 2);
    }

    //Update time counter
    _timeSinceStep += t;

    //Add any new items if necessary
    itemGenerator.getNewItem(_items);

    //If it's time to update the screen, do so.
    if (_timeSinceStep >= _stepTime) {
      _timeSinceStep = 0;
      //Iterate over all currently visible items
      for (int i = 0; i < _items.length; i++) {
        Item currItem = _items[i];

        //Make sure y position is properly adjusted
        currItem.yPos = screenSize.height / 2;

        //If the item has gone off the screen, remove it.
        if (currItem.width <= 0) {
          _items.removeAt(i);
        }
        //If the item has reached the end of the screen, shorten it.
        else if (currItem.xPos + currItem.width >= screenSize.width) {
          currItem.width -= 1;
        }
        //Otherwise just move the item along
        else {
          currItem.xPos += 1;
        }
      }
    }
  }

  void resize(Size size) {
    screenSize = size;
    super.resize(size);
  }
}
